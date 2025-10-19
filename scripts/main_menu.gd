extends Node2D

@export var colors_schemes = []
@export var colors_schemes_bg = []
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var scheme_id = rng.randi_range(0, len(colors_schemes) - 1)
	var scheme = colors_schemes[scheme_id]
	var schemebg = colors_schemes_bg[scheme_id]
	var ident = ["topleft", "topright", "bottomleft", "bottomright"]
	if save_manager.high_contrast_mode != true:
		for i in range(0,4):
			RenderingServer.global_shader_parameter_set(ident[i], scheme[i])
		for i in range(0,4):
			RenderingServer.global_shader_parameter_set(ident[i] + "bg", schemebg[i])
	transition_in()

func _on_play_pressed() -> void:
	await transition()
	self.get_parent().add_child(load("res://scenes/level_menu.tscn").instantiate())
	self.queue_free()


func _on_credits_pressed() -> void:
	$Camera2D.position.x += 1152

func _on_credits_back_pressed() -> void:
	$Camera2D.position.x -= 1152

func transition():
	var timer = get_tree().create_timer(0.25)

	while timer.time_left != 0:
		$buttons.modulate.a = 4 * timer.time_left
		$signal.modulate.a = 4 * timer.time_left
		$wall.modulate.a = 4 * timer.time_left
		$wall2.modulate.a  = 4 * timer.time_left
		$Label.modulate.a  = 4 * timer.time_left
		await get_tree().process_frame

	return

func transition_in():
	var timer = get_tree().create_timer(0.25)
	
	while timer.time_left != 0:
		$buttons.modulate.a =1 - 4 * timer.time_left
		$signal.modulate.a = 1- 4 * timer.time_left
		$wall.modulate.a =1- 4 * timer.time_left
		$wall2.modulate.a  =1- 4 * timer.time_left
		$Label.modulate.a  = 1-4 * timer.time_left
		await get_tree().process_frame


func _on_credits_back_2_pressed() -> void:
	$Camera2D.position.x += 1152



func _on_settings_pressed() -> void:
	$Camera2D.position.x -= 1152
