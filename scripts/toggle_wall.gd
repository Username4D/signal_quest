extends StaticBody2D

@export var toggled = true

func press():
	toggled = not toggled

func _process(delta: float) -> void:
	$CollisionShape2D.disabled = not toggled
	$MeshInstance2D.visible = toggled
