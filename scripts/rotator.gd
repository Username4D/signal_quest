extends AnimatableBody2D

@export var target_n: Node
@export var target_o: Node
@export var target_s: Node
@export var target_w: Node

@export var speed = 90

var vrotation_degrees = 0

var target_rotation = 0
var og = 0
func press():
	target_rotation += 90
	audio_handler.request("rotator", self)
func _physics_process(delta: float) -> void:

	vrotation_degrees = move_toward(vrotation_degrees, target_rotation, speed * delta)

	for i in [target_n, target_o, target_s, target_w]:
		
		if i:
	
			i.rotation_degrees += vrotation_degrees - og
	
	if target_n:
		target_n.global_position = $n.global_position
	if target_o:
		target_o.global_position = $o.global_position
	if target_s:
		target_s.global_position = $s.global_position
	if target_w:
		target_w.global_position = $w.global_position
	og = vrotation_degrees 
	self.rotation_degrees = vrotation_degrees
