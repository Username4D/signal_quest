extends Sprite2D

var signal_scene = preload("res://scenes/signal.tscn")
@export var passive = false


func press():
	if passive:
		var signal_obj = signal_scene.instantiate()
		signal_obj.position = self.position
		signal_obj.rotation = self.rotation
		self.get_parent().get_parent().get_node("signals").add_child(signal_obj)

func start():
	if not passive:
		var signal_obj = signal_scene.instantiate()
		signal_obj.position = self.position
		signal_obj.rotation = self.rotation
		self.get_parent().get_parent().get_node("signals").add_child(signal_obj)
	
func _ready() -> void:
	self.get_parent().get_parent().start.connect(start)
