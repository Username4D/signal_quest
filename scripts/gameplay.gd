extends Node2D

@export var current_level = 1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		$pause_menu.visible = not $pause_menu.visible

func close():
	$level.cose()
func back():
	pass
func finish():
	$finish.visible = true

func _ready() -> void:
	var level_scene = load("res://scenes/levels/level_" + var_to_str(current_level) + ".tscn").instantiate()
	self.add_child(level_scene)
