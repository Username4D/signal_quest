extends AnimatableBody2D

@export var points = []
@export var speed = 256

var moved = false
var current = 0
func press():
	moved = true

func _physics_process(delta: float) -> void:
	if self.position == points[current]:

		if not current == len(points) - 1:
			current += 1
		else:
			moved = false
	if moved:
		self.position = self.position.move_toward(points[current], speed * delta)
		

func _process(delta: float) -> void:
	$points.clear_points()
	for i in points:
		$points.add_point(i - self.position)
