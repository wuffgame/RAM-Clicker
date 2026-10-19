extends TextureButton

@export var scale_reduction: float = 0.95
@export var tween_duration: float = 0.05


@export var ram_textures: Array[Texture2D] = []

var original_scale: Vector2
var original_position: Vector2

@onready var counter_label: Label = get_node("../Counter")
@onready var explosion: GPUParticles2D = get_node("Effect")
@onready var name_label: Label = get_node("../Name of RAM")
@onready var Counter_effects: Label = get_node("../Counter/Counter_effects")
@onready var Multi_label: Label = get_node("../Multi Label")

func _ready() -> void:
	original_scale = scale
	original_position = position
	pressed.connect(_on_pressed)
	if Counter_effects:
		Counter_effects.visible = false
	update_counter_display()
	update_ram_display()
	multi_label_update()

func _on_pressed() -> void:
	if explosion:
		explosion.restart()
		explosion.emitting = true
	play_click_effect()
	var gained_value = 1 * Global.multi
	Global.counter += gained_value
	if Counter_effects:
		var fx = Counter_effects.duplicate() as Label
		fx.visible = true
		Counter_effects.get_parent().add_child(fx)
		fx.global_position = counter_label.global_position + (counter_label.size * counter_label.scale / 2.0) + Vector2(-20, -30)
		fx.text = "+" + format_bytes(gained_value)
		var tween = create_tween().set_parallel(true)
		tween.tween_property(fx, "global_position", fx.global_position + Vector2(0, -50), 0.5)\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(fx, "modulate:a", 0.0, 0.4)\
			.set_delay(0.1)\
			.set_ease(Tween.EASE_IN)
		tween.chain().tween_callback(fx.queue_free)
	update_counter_display()
	update_ram_display()
	multi_label_update()
	
func update_counter_display() -> void:
	if counter_label:
		counter_label.text = format_bytes(Global.counter)


func update_ram_display() -> void:
	var names = ["Intek 3101", "Intek 1103", "SOM 6550", "Bridge MK4116", "SMT4416", "MH51256", "SIMM 256 KB", "SIMM 1MB", "SIMM 4MB", "DEO RAM 16MB", "SDRAM 64MB", "SDRAM 256MB", "DDR-266 512MB", "DDR-400 1GB", "DDR2-800 2GB", "DDR2-1066 4GB", "DDR3-1600 8GB", "DDR3-2133 16GB", "DDR4-3200 32GB", "DDR4-4000 64GB", "DDR5-6000 128GB", "DDR5-8000 256GB", "RDIMM 1TB", "LRDIMM 4TB", "Quantum RAM Module 16TB", "HBM4 MegaCluster 64TB", "Synaptic Array 256TB", "ExaDrive Crystal 1PB", "Molecular Lattice 16PB", "Neuromorphic Core 256PB", "Photonic Lattice 1EB", "Sub-Atomic Spin-Grid 16EB", "Dyson Swarm Buffer 256EB", "Chrono-Spatial Matrix 1ZB", "Galactic Core Matrix 16ZB", "Dark Matter Bank 256ZB", "Universal Hologram 4096ZB", "Omniverse Matrix 65536ZB", "Singularity Core 1048576ZB"]
	
	# change name
	if name_label and Global.RAM_number < names.size():
		name_label.text = names[Global.RAM_number]
		
	# change txt
	if Global.RAM_number < ram_textures.size() and ram_textures[Global.RAM_number] != null:
		texture_normal = ram_textures[Global.RAM_number]

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
		
func multi_label_update() -> void:
	Multi_label.text = "Mult: x" + str(Global.multi)
