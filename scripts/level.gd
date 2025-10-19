extends Node2D

@export var game_state = "build" # build, finish, start
signal start
signal build
signal finish
@export var inventory =  {
 "wall": 2,
 "wall_angled": 3,
 "signal_emitter": 0, 
 "moveable_body": 5,
 "rotator": 0,
 "button": 0,
 "moveable_body_angled": 0,
 "finish": 0,
 "gated_button": 0,
 "toggle_wall": 0
}
@export var colors = [Color.HONEYDEW, Color.ALICE_BLUE, Color.ANTIQUE_WHITE, Color.CHOCOLATE]
@export var colorsbg = [Color.HONEYDEW, Color.ALICE_BLUE, Color.ANTIQUE_WHITE, Color.CHOCOLATE]
func _ready() -> void:
	gameplay_handler.inventory = inventory
	var ident = ["topleft", "topright", "bottomleft", "bottomright"]
	if not save_manager.high_contrast_mode:
		for i in range(0,4):
			RenderingServer.global_shader_parameter_set(ident[i], colors[i])
		for i in range(0,4):
			RenderingServer.global_shader_parameter_set(ident[i] + "bg", colorsbg[i])
	build.emit()
	for i in $conversions.get_children():
		if not i.is_in_group("premade"):
			i.queue_free()

	$user_gp_objects.visible = true
	await get_tree().process_frame
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_start") and self.get_parent().get_node("pause_menu").visible == false:
		if game_state == "build":
			game_state = "start"
			start.emit()

			convert_placements($user_gp_objects)
			$user_gp_objects.visible = false
		elif game_state == "start" or game_state == "finish":
			self.get_parent().get_node("finish").visible = false
			game_state = "build"
			build.emit()
			for i in $conversions.get_children():
				if not i.is_in_group("premade"):
					i.queue_free()

			$user_gp_objects.visible = true
func convert_placements(parent: Node):
	await get_tree().process_frame
	var inventory =  {
	"wall": preload("res://scenes/wall.tscn"),
	"wall_angled": preload("res://scenes/wall_angled.tscn"),
	"signal_emitter": preload("res://scenes/signal_emitter.tscn"), 
	"moveable_body": preload("res://scenes/moveable_body.tscn"),
	"rotator": preload("res://scenes/rotator.tscn"),
	"button": preload("res://scenes/button.tscn"),
	"moveable_body_angled": preload("res://scenes/moveable_body_angled.tscn"),
	"finish": Node.new(),
	"gated_button": preload("res://scenes/gated_button.tscn"),
	"toggle_wall": preload("res://scenes/toggle_wall.tscn")
	}
	
	var linker_tasks = []
	var linker_origins = []
	var old_links
	for i in $conversions.get_children():
		if i.name == "rotator":
			old_links = i
	for i in parent.get_children():
		var obj = inventory[i.Item].instantiate()
		obj.position = i.global_position + Vector2(32,32)
		obj.rotation = i.get_node("sprite").rotation
		if i.Item == "rotator" or i.Item == "button" or i.Item == "signal_emitter":
			linker_tasks.append(obj)
			linker_origins.append(i)
		$conversions.add_child(obj)
	if old_links:
		old_links.rotation_degrees = 0
		old_links.vrotation_degrees = 0
		old_links.target_rotation = 0
		old_links.target_w = null
		old_links.target_o = null
		old_links.target_n = null
		old_links.target_s = null
		await get_tree().process_frame
		for n in $conversions.get_children():
			if n.position == (old_links.position- Vector2(64, 0)):
				old_links.target_w = n
				old_links.wo = n.rotation
			if n.position == (old_links.position- Vector2(-64, 0)):
				old_links.target_o = n
				old_links.oo = n.rotation
			if n.position == (old_links.position- Vector2(0, 64)):
				old_links.target_n = n
				old_links.no = n.rotation
			if n.position == (old_links.position- Vector2(0, -64)):
				old_links.target_s = n
				old_links.so = n.rotation
	for i in range(0, len(linker_tasks)):
		match linker_origins[i].Item:
			"rotator":
				linker_tasks[i].rotation_degrees = 0
				for n in $conversions.get_children():
					if n.position == (linker_tasks[i].position- Vector2(64, 0)):
						linker_tasks[i].target_w = n
						linker_tasks[i].wo = n.rotation
					if n.position == (linker_tasks[i].position- Vector2(-64, 0)):
						linker_tasks[i].target_o = n
						linker_tasks[i].oo = n.rotation
					if n.position == (linker_tasks[i].position- Vector2(0, 64)):
						linker_tasks[i].target_n = n
						linker_tasks[i].no = n.rotation
					if n.position == (linker_tasks[i].position- Vector2(0, -64)):
						linker_tasks[i].target_s = n
						linker_tasks[i].so = n.rotation
			"button":
		

				for n in $conversions.get_children():
					if round(n.position) == round(linker_tasks[i].position + Vector2(-64,0).rotated(linker_tasks[i].rotation )):
						linker_tasks[i].Target = n


			"signal_emitter":
				linker_tasks[i].passive = true
				linker_tasks[i].press()

func cose():
	self.get_parent().get_node("finish").visible = false
	game_state = "build"
	build.emit()
	for i in $conversions.get_children():
		if not i.is_in_group("premade"):
			i.queue_free()

	$user_gp_objects.visible = true
