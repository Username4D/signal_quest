extends ColorRect

func _on_close_pressed() -> void:
	self.visible = false

func _on_reset_pressed() -> void:
	self.get_parent().reset()

func _on_back_pressed() -> void:
	self.get_parent().back()
