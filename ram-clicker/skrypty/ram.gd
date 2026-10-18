extends TextureButton

@export var scale_reduction: float = 0.95
@export var tween_duration: float = 0.05

var original_scale: Vector2
var original_position: Vector2

@onready var counter_label: Label = get_node("../Counter")
@onready var explosion: GPUParticles2D = get_node("Effect")

func _ready() -> void:
	original_scale = scale
	original_position = position
	pressed.connect(_on_pressed)
	update_counter_display()

func _on_pressed() -> void:
	if explosion:
		explosion.restart()
		explosion.emitting = true
	play_click_effect()
	Global.counter += 1 * Global.multi
	update_counter_display()
	
func update_counter_display() -> void:
	if counter_label:
		counter_label.text = format_bytes(Global.counter)

func play_click_effect() -> void:
	var tween = create_tween().set_parallel(true)
	
	var size_diff = size * (1.0 - scale_reduction) * original_scale / 2.0

	tween.tween_property(self, "scale", original_scale * scale_reduction, tween_duration)
	tween.tween_property(self, "position", original_position + size_diff, tween_duration)

	await tween.finished

	var return_tween = create_tween().set_parallel(true)
	return_tween.tween_property(self, "scale", original_scale, tween_duration)
	return_tween.tween_property(self, "position", original_position, tween_duration)
	
func format_bytes(bytes: float) -> String:
	var units = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB"]
	var i = 0
	
	while bytes >= 1024.0 and i < units.size() - 1:
		bytes /= 1024.0
		i += 1
	if i == 0:
		return "%d %s" % [bytes, units[i]]
	else:
		return "%.2f %s" % [bytes, units[i]]
