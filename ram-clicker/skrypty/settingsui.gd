extends Control
@onready var resolution_button: OptionButton = $MarginContainer/VBoxContainer/OptionButton


func _ready() -> void:
	resolution_button.clear()
	resolution_button.add_item("1920x1080")
	resolution_button.add_item("1600x900")
	resolution_button.add_item("1280x720")
	
func _on_option_button_item_selected(index: int) -> void:
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))
	


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
