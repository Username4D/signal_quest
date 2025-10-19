extends Node2D

func _ready() -> void:
	$CheckBox.button_pressed = save_manager.high_contrast_mode
	$volume.value = save_manager.sfx_volume
func update():
	save_manager.high_contrast_mode = $CheckBox.button_pressed
	save_manager.sfx_volume = $volume.value
	save_manager.save()



func _on_volume_value_changed(value: float) -> void:
	save_manager.high_contrast_mode = $CheckBox.button_pressed
	save_manager.sfx_volume = $volume.value
	save_manager.save()
