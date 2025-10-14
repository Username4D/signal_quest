extends Sprite2D

var signal_scene = preload("res://scenes/signal.tscn")
@export var passive = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_start") and not passive:
		var signal_obj = signal_scene.instantiate()
		signal_obj.position = self.position
		signal_obj.rotation = self.rotation
		self.get_parent().add_child(signal_obj)
func press():
	if passive:
		var signal_obj = signal_scene.instantiate()
		signal_obj.position = self.position
		signal_obj.rotation = self.rotation
		self.get_parent().add_child(signal_obj)
