extends Node2D

func _ready() -> void:
	$content.modulate.a = 0
	for i in $content/level_button_lines.get_children():
		i.get_node("Label").text = i.name
	var timer = get_tree().create_timer(0.25)
	while timer.time_left != 0:
		$content.modulate.a = 1 - 4 * timer.time_left
		await get_tree().process_frame
	$content.modulate.a = 1 
	
func _on_credits_back_pressed() -> void:
	var timer = get_tree().create_timer(0.25)
	while timer.time_left != 0:
		$content.modulate.a = 4 * timer.time_left
		await get_tree().process_frame
	$content.modulate.a = 0
	self.get_parent().add_child(load("res://scenes/main_menu.tscn").instantiate())
	self.queue_free()
