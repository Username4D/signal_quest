extends CharacterBody2D

const speed = 250

func _physics_process(delta: float) -> void:
	if self.rotation_degrees >= 0:
		self.rotation_degrees -= 360
	if self.rotation_degrees <= -360:
		self.rotation_degrees += 360
	velocity = Vector2(speed * delta, 0).rotated(self.rotation)
	move_and_collide(velocity)
	if $ray.is_colliding():
		print(self.rotation_degrees )
		print("wall")
		if $ray.get_collider().is_in_group("wall_angled"):
			if $ray.get_collider().rotation_degrees == self.rotation_degrees:
				self.rotation_degrees += 90
			elif $ray.get_collider().rotation_degrees - 90 == self.rotation_degrees:
				self.rotation_degrees += -90
			else:
				self.rotation_degrees += 180
		elif $ray.get_collider().is_in_group("button"):
			$ray.get_collider().press()
			self.rotation_degrees += 180
		else:
			self.rotation_degrees += 180
		self.rotation_degrees = round(self.rotation_degrees)
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_start"):
		self.queue_free()
