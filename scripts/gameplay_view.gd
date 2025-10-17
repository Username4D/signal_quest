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

func _ready() -> void:
	gameplay_handler.inventory = inventory

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
