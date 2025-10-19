extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		$pause_menu.visible = not $pause_menu.visible

func reset():
	pass
func back():
	pass
