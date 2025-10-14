extends CharacterBody2D

const speed = 250

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed * delta, 0).rotated(self.rotation)
	move_and_collide(velocity)
	if $ray.is_colliding():
		print("wall")
		if $ray.get_collider().is_in_group("wall_angled"):
			if $ray.get_collider().rotation_degrees == self.rotation_degrees:
				self.rotation_degrees += 90
			elif $ray.get_collider().rotation_degrees - 90 == self.rotation_degrees:
				self.rotation_degrees += -90
			else:
				self.rotation_degrees += 180
		else:
			self.rotation_degrees += 180
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_start"):
		self.queue_free()
