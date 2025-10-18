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
	for i in range(0,4):
		RenderingServer.global_shader_parameter_set(ident[i], scheme[i])
	for i in range(0,4):
		RenderingServer.global_shader_parameter_set(ident[i] + "bg", schemebg[i])

func _on_play_pressed() -> void:
	self.get_parent().add_child(load("res://scenes/level_menu.tscn").instantiate())
	self.queue_free()


func _on_credits_pressed() -> void:
	$Camera2D.position.x += 1152

func _on_credits_back_pressed() -> void:
	$Camera2D.position.x -= 1152
