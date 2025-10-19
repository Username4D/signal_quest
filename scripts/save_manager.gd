extends Node

var max_level = 0
var sfx_volume = 1
var high_contrast_mode = false

func _ready() -> void:
	var file = FileAccess.open("user://userdata.dat", FileAccess.READ)
	if file != null:
		var content = file.get_var()
		max_level = content["max_level"]
		sfx_volume = content["sfx_volume"]
		high_contrast_mode = content["high_contrast_mode"]
		file.close()
func save():
	var file = FileAccess.open("user://userdata.dat", FileAccess.WRITE)
	file.store_var({"max_level": max_level, "high_contrast_mode": high_contrast_mode, "sfx_volume": sfx_volume})
	file.close()
