extends AnimatableBody2D

@export var target_n: Node
@export var target_o: Node
@export var target_s: Node
@export var target_w: Node
 
@export var speed = 90

@export var vrotation_degrees = 0

@export var target_rotation = 0

@export var no = 0
@export var  oo = 0
@export var so = 0
@export var wo = 0
@export var og = 0
func press():
	
	target_rotation += 90
	audio_handler.request("rotator", self)
func _physics_process(delta: float) -> void:
	self.rotation_degrees = vrotation_degrees 
	vrotation_degrees = move_toward(vrotation_degrees, target_rotation, speed * delta)


	
	if target_n:
		target_n.global_position = $n.global_position
		target_n.rotation = self.rotation + no
	if target_o:
		target_o.global_position = $o.global_position
		target_o.rotation = self.rotation + oo
	if target_s:
		target_s.global_position = $s.global_position
		target_s.rotation = self.rotation  + so
	if target_w:
		target_w.global_position = $w.global_position
		target_w.rotation = self.rotation + wo
	og = vrotation_degrees 
	
