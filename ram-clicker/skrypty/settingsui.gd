extends Control


func _on_volume_value_changed(value: float) -> void:
	if value <= 0:
		AudioServer.set_bus_mute(0, false)
	else:
		AudioServer.set_bus_mute(0, false)
		var linear_volume = value / 100.0
		var db_volume = linear_to_db(linear_volume)
		AudioServer.set_bus_volume_db(0, db_volume)


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://sceny/menu.tscn")
