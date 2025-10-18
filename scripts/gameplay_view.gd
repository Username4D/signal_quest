extends Node2D

@export var game_state = "build" # build, finish, start
signal start
signal build

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
	for i in range(0,4):
		RenderingServer.global_shader_parameter_set(ident[i], colors[i])
	for i in range(0,4):
		RenderingServer.global_shader_parameter_set(ident[i] + "bg", colorsbg[i])
	build.emit()
	for i in $conversions.get_children():
		i.queue_free()
	print("build")
	$user_gp_objects.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_start"):
		if game_state == "build":
			game_state = "start"
			start.emit()
			print("start")
			convert_placements($user_gp_objects)
			$user_gp_objects.visible = false
		elif game_state == "start":
			game_state = "build"
			build.emit()
			for i in $conversions.get_children():
				i.queue_free()
			print("build")
			$user_gp_objects.visible = true
func convert_placements(parent: Node):
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
	
	for i in parent.get_children():
		var obj = inventory[i.Item].instantiate()
		obj.position = i.global_position + Vector2(32,32)
		obj.rotation = i.get_node("sprite").rotation
		if i.Item == "rotator" or i.Item == "button":
			linker_tasks.append(obj)
			linker_origins.append(i)
		$conversions.add_child(obj)
	
	for i in range(0, len(linker_tasks)):
		match linker_origins[i].Item:
			"rotator":
				linker_tasks[i].rotation_degrees = 0
				for n in $conversions.get_children():
					if n.position == (linker_tasks[i].position- Vector2(64, 0)):
						linker_tasks[i].target_w = n
					if n.position == (linker_tasks[i].position- Vector2(-64, 0)):
						linker_tasks[i].target_o = n
					if n.position == (linker_tasks[i].position- Vector2(0, 64)):
						linker_tasks[i].target_n = n
					if n.position == (linker_tasks[i].position- Vector2(0, -64)):
						linker_tasks[i].target_s = n
			"button":
				linker_tasks[i].rotation_degrees += 180
				print(round(Vector2(-64,0).rotated(linker_tasks[i].rotation)))
				for n in $conversions.get_children():
					if round(n.position) == round(linker_tasks[i].position + Vector2(64,0).rotated(linker_tasks[i].rotation)):
						linker_tasks[i].Target = n
						print("found")
					else:
						print("scan")
						print(round(n.position))
						print(round(linker_tasks[i].position + Vector2(-64,0).rotated(linker_tasks[i].rotation)))
