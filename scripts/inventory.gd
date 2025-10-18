extends HBoxContainer

var items=  [
 "wall",
 "wall_angled",
 "signal_emitter", 
 "moveable_body",
 "rotator",
 "button",
 "moveable_body_angled",
 "finish",
 "gated_button",
 "toggle_wall"
]

var item_scene = preload("res://scenes/inventory_item.tscn")

func _ready() -> void:
	for i in items:
		var scene = item_scene.instantiate()
		scene.name = i
		self.add_child(scene)
	self.get_parent().build.connect(func (): self.visible = true,)
	self.get_parent().start.connect(func (): self.visible = false,)
