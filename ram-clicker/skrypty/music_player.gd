extends AudioStreamPlayer

var playlist : Array[AudioStream] = [
	preload("res://music/1.mp3"),
	preload("res://music/2.mp3"),
	preload("res://music/3.mp3"),
	preload("res://music/4.mp3")
]

var current_track_index : int = 0

func _ready() -> void:
	finished.connect(_on_finished)
	play_track(current_track_index)

func play_track(index: int) -> void:
	if playlist.size() == 0:
		return
	stream = playlist[index]
	play()

func _on_finished() -> void:
	current_track_index = (current_track_index + 1) % playlist.size()
	play_track(current_track_index)
