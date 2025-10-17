extends Button

var atlas_position = {"wall": Vector2(0,0), "wall_angled": Vector2(64,0), "signal_emitter": Vector2(128, 0), "moveable_body": Vector2(192, 0), "rotator": Vector2(0, 64), "button": Vector2(64,64), "moveable_body_angled": Vector2(192, 64), "finish": Vector2(0, 128), "gated_button": Vector2(64, 128), "toggle_wall": Vector2(128,128)}
@export var Item = "wall"
var ideal_position = Vector2.ZERO
@export var state_pressed = true
func _process(delta: float) -> void:
	if self.state_pressed:
		$sprite.scale = Vector2(0.7, 0.7)
		ideal_position = psnapped(get_global_mouse_position() - Vector2(32,32))
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			state_pressed = false
	else:
		$sprite.scale = Vector2.ONE
	self.position = self.position.move_toward(ideal_position, 1024* delta)
func _ready() -> void:
	$sprite.texture.region = Rect2(atlas_position[Item], Vector2(64,64))
	ideal_position = self.position
func psnapped(position: Vector2):
	return round(position / 64) * 64

func _on_button_up() -> void:
	state_pressed = false

func _on_button_down() -> void:
	state_pressed = true

	
