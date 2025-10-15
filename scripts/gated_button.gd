extends Area2D


@export var Target: Node

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("signal") and Target:
		Target.press()
