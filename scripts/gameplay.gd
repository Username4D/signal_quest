extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		$pause_menu.visible = not $pause_menu.visible

func close():
	$level.cose()
func back():
	pass
func finish():
	$finish.visible = true
