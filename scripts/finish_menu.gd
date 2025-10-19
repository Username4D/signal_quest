extends ColorRect

func _on_close_pressed() -> void:
	self.visible = false
	self.get_parent().close()

func _on_back_pressed() -> void:
	self.get_parent().back()
