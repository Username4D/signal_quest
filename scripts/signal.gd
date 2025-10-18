extends CharacterBody2D

const speed = 250

var rotation_virtual = 0

func _physics_process(delta: float) -> void:
	
	velocity = Vector2(speed * delta, 0).rotated(deg_to_rad(rotation_virtual))
	
	
	
	if $ray.is_colliding():

		if $ray.get_collider().is_in_group("wall_angled"):
			
			if fmod(round($ray.get_collider().rotation_degrees ), 360)== round(self.rotation_virtual):
				self.rotation_virtual += 90
			elif fmod(round($ray.get_collider().rotation_degrees ) + 270, 360) == round(self.rotation_virtual) or fmod(round($ray.get_collider().rotation_degrees ) - 90, 360) == round(self.rotation_virtual):
				self.rotation_virtual += -90
			else:
				
				self.rotation_virtual += 180
			
			audio_handler.request("wall", self)
		elif $ray.get_collider().is_in_group("button"):
			$ray.get_collider().press()
			self.rotation_virtual += 180
			audio_handler.request("button", self)
		elif $ray.get_collider().is_in_group("finish"):
			audio_handler.request("start", self.get_parent())
			self.get_parent().get_parent().finish.emit()
			self.get_parent().get_parent().game_state = "finish"
			self.queue_free()
		else:
			audio_handler.request("wall", self)
			self.rotation_virtual += 180
	self.rotation_virtual = round(self.rotation_virtual)
	self.rotation_virtual = fmod(rotation_virtual, 360)
	$ray.rotation_degrees = rotation_virtual
	move_and_collide(velocity)
func stop() -> void:
	self.queue_free()

func _ready() -> void:
	self.get_parent().get_parent().build.connect(stop)
