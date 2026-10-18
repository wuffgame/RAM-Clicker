extends Control

@onready var resolution_button: OptionButton = $MarginContainer/VBoxContainer/OptionButton

func _ready() -> void:
	
	resolution_button.clear()
	resolution_button.add_item("1920x1080")
	resolution_button.add_item("1600x900")
	resolution_button.add_item("1280x720")
	
	
   
	resolution_button.select(0)
	
   
	if not resolution_button.item_selected.is_connected(_on_option_button_item_selected):
		resolution_button.item_selected.connect(_on_option_button_item_selected)

func _on_option_button_item_selected(index: int) -> void:
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	var new_size: Vector2i
	match index:
		0:
			new_size = Vector2i(1920, 1080)
		1:
			new_size = Vector2i(1600, 900)
		2:
			new_size = Vector2i(1280, 720)
		_:
			return

  
	DisplayServer.window_set_size(new_size)
	get_window().size = new_size
	
   
	_center_window()

func _center_window() -> void:
	var screen_index = DisplayServer.window_get_current_screen()
	var screen_center = DisplayServer.screen_get_position(screen_index) + DisplayServer.screen_get_size(screen_index) / 2
	var window_size = DisplayServer.window_get_size()
	DisplayServer.window_set_position(screen_center - window_size / 2)

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)

func _on_check_box_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
