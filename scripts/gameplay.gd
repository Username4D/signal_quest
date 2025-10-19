extends Node2D

@export var current_level = 1
var level = null

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		$pause_menu.visible = not $pause_menu.visible

func reset():
	level.queue_free()
	var level_scene = load("res://scenes/levels/level_" + var_to_str(current_level) + ".tscn").instantiate()
	self.add_child(level_scene)
	level = level_scene

func close():
	$level.cose()
func back():
	var timer = get_tree().create_timer(0.25)
	while timer.time_left != 0:
		$pause_menu.modulate.a = timer.time_left * 4
		level.modulate.a = timer.time_left * 4
		$finish.modulate.a = timer.time_left * 4
		await get_tree().process_frame
	self.get_parent().add_child(load("res://scenes/level_menu.tscn").instantiate())
	self.queue_free()
func finish():
	$finish.visible = true
	if save_manager.max_level <= current_level:
		save_manager.max_level = current_level + 1
		save_manager.save()
	

func _ready() -> void:
	var level_scene = load("res://scenes/levels/level_" + var_to_str(current_level) + ".tscn").instantiate()
	self.add_child(level_scene)
	level = level_scene
