extends Button

var atlas_position = {"wall": Vector2(0,0), "wall_angled": Vector2(64 + 8,0), "signal_emitter": Vector2(128 + 16, 0), "moveable_body": Vector2(192 + 24, 0), "rotator": Vector2(0, 64 + 8), "button": Vector2(64 + 8,64 + 8), "moveable_body_angled": Vector2(192 + 24, 64 + 8), "finish": Vector2(0, 128), "gated_button": Vector2(64 + 8, 128 + 16), "toggle_wall": Vector2(128 + 16,128 + 16)}
@export var Item = "wall"
var ideal_position = Vector2.ZERO
@export var state_pressed = true
func _process(delta: float) -> void:
	if self.state_pressed:
		if Input.is_action_just_pressed("ui_rotate"):
			$sprite.rotation_degrees += 90
		if self.get_parent().get_parent().get_node("static_gp_tilemap").get_cell_source_id(psnapped(self.position) / 64) == -1:
			$sprite.scale = Vector2(0.2,0.2)
	
		else:
			$sprite.scale = Vector2(0.125,0.125)

		ideal_position = psnapped(get_global_mouse_position() -Vector2(32,32))
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			state_pressed = false
			if not self.get_parent().get_parent().get_node("static_gp_tilemap").get_cell_source_id(psnapped(self.position) / 64) == -1:
				gameplay_handler.inventory[Item] += 1
				self.queue_free()
				
			for i in self.get_parent().get_children():
				if i.position == ideal_position and i.name != self.name:
					gameplay_handler.inventory[i.Item] += 1
					i.queue_free()
	else:
		$sprite.scale = Vector2(.25,.25 )
	self.position = self.position.move_toward(ideal_position, 1024* delta)
func _ready() -> void:
	$sprite.texture.region = Rect2(atlas_position[Item] * 4, Vector2(256,256))
	ideal_position = self.position
func psnapped(position: Vector2):
	return round(position / 64) * 64



func _on_button_down() -> void:
	state_pressed = true

	
