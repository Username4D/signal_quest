extends Node2D

@export var game_state = "build" # build, finish, start
signal start
signal build

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_start"):
		if game_state == "build":
			game_state = "start"
			start.emit()
			print("start")
		elif game_state == "start":
			game_state = "build"
			build.emit()
			print("build")
