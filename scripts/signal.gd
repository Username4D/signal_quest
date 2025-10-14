extends CharacterBody2D

const speed = 250

func _physics_process(delta: float) -> void:
	self.rotation_degrees = round(self.rotation_degrees)

	if self.rotation_degrees >= 360:
		self.rotation_degrees -= 360
	if self.rotation_degrees <0:
		self.rotation_degrees += 360
	velocity = Vector2(speed * delta, 0).rotated(self.rotation)
	move_and_collide(velocity)
	if $ray.is_colliding():

		if $ray.get_collider().is_in_group("wall_angled"):
			print(round($ray.get_collider().rotation_degrees )== round(self.rotation_degrees))
			print(round($ray.get_collider().rotation_degrees ), round(self.rotation_degrees))
			if round($ray.get_collider().rotation_degrees )== round(self.rotation_degrees):
				self.rotation_degrees += 90
			elif round($ray.get_collider().rotation_degrees - 90) == round(self.rotation_degrees):
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
