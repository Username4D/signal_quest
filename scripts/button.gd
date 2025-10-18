extends StaticBody2D

var on_cooldown = false
@export var Target: Node

func press():
	if not on_cooldown and Target:
		Target.press()
		on_cooldown = true
		$button_pressed.visible = true
		$button_unpressed.visible = false
		get_tree().create_timer(0.3).timeout.connect(cooldown_end)
	print("LOL")
func cooldown_end():
	on_cooldown = false
	$button_pressed.visible = false
	$button_unpressed.visible = true
	
