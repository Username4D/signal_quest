extends StaticBody2D

@export var toggled = true

func press():
	toggled = not toggled
	print("toggled")
	

func _process(delta: float) -> void:
	$MeshInstance2D.modulate.a= 0 if not toggled else 1
	$CollisionShape2D.disabled = not toggled
	
func _ready() -> void:
	self.get_parent().get_parent().build.connect(func (): toggled = true,)
