extends CharacterBody2D

const speed = 250

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed * delta, 0).rotated(self.rotation)
	move_and_collide(velocity)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_start"):
		self.queue_free()
