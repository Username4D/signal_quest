extends Node2D

func _ready() -> void:
	for i in $level_button_lines.get_children():
		i.get_node("Label").text = i.name
