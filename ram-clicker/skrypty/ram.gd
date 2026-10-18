extends TextureButton

@export var scale_reduction: float = 0.95
@export var tween_duration: float = 0.05

var original_scale: Vector2

func _ready() -> void:
	original_scale = scale
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	play_click_effect()
	Global.counter += 1 * Global.multi
	
func play_click_effect() -> void:
	var tween = create_tween().set_parallel(false)
	tween.tween_property(self, "scale", original_scale * scale_reduction, tween_duration)
	tween.tween_property(self, "scale", original_scale, tween_duration)
