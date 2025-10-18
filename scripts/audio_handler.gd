extends Node

var button = preload("res://assets/button.wav")
var sounds = {"button": "res://assets/button.wav", "wall": "res://assets/wall.wav", "rotator": "res://assets/rotator.wav", "start": "res://assets/start.wav"}
func request(audio: String, host: Node):
	var stream = AudioStreamPlayer.new()
	stream.stream = AudioStreamWAV.load_from_file(sounds[audio])
	if audio == "start":
		stream.volume_db -= 16
	host.add_child.call_deferred(stream)
	 
	stream.playing = true
	await stream.finished
	stream.queue_free()
