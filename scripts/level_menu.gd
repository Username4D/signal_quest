extends Node2D

func _ready() -> void:
	for i in $content/level_button_lines.get_children():
		i.get_node("Label").text = i.name
	var timer = get_tree().create_timer(0.25)
	while timer.time_left != 0:
		$content.modulate.a = 1 - 4 * timer.time_left
		await get_tree().process_frame
	$content.modulate.a = 1 
	
