extends Button

@export var amount = 2
var atlas_position = {"wall": Vector2(0,0), "wall_angled": Vector2(64,0), "signal_emitter": Vector2(128, 0), "moveable_body": Vector2(192, 0), "rotator": Vector2(0, 64), "button": Vector2(64,64), "moveable_body_angled": Vector2(192, 64), "finish": Vector2(0, 128), "gated_button": Vector2(64, 128), "toggle_wall": Vector2(128,128)}
var placed_object_scene = preload("res://scenes/placed_object.tscn")

func _ready() -> void:
	self.icon.region = Rect2(atlas_position[self.name], Vector2(64,64))

func _process(delta: float) -> void:
	$amount.text = var_to_str(amount)



func _on_pressed() -> void:
	var placed_object =placed_object_scene.instantiate()
	placed_object.position = self.global_position
	placed_object.Item = self.name
	self.get_parent().get_parent().get_node("user_gp_objects").add_child(placed_object)
	placed_object.state_pressed = true
	placed_object.pressed.emit()
