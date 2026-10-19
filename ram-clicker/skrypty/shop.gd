extends Control

#variable that holds cost of upgrade
var upgrade_cost: float = 50.0

#ram names
var names = [
	"Intek 3101", "Intek 1103", "SOM 6550", "Bridge MK4116", "SMT4416", "MH51256", "SIMM 256 KB", "SIMM 1MB", "SIMM 4MB", "DEO RAM 16MB", "SDRAM 64MB", "SDRAM 256MB", "DDR-266 512MB", "DDR-400 1GB", "DDR2-800 2GB", "DDR2-1066 4GB", "DDR3-1600 8GB", "DDR3-2133 16GB", "DDR4-3200 32GB", "DDR4-4000 64GB", "DDR5-6000 128GB", "DDR5-8000 256GB", "RDIMM 1TB", "LRDIMM 4TB", "Quantum RAM Module 16TB", "HBM4 MegaCluster 64TB", "Synaptic Array 256TB", "ExaDrive Crystal 1PB", "Molecular Lattice 16PB", "Neuromorphic Core 256PB", "Photonic Lattice 1EB", "Sub-Atomic Spin-Grid 16EB", "Dyson Swarm Buffer 256EB", "Chrono-Spatial Matrix 1ZB", "Galactic Core Matrix 16ZB", "Dark Matter Bank 256ZB", "Universal Hologram 4096ZB", "Omniverse Matrix 65536ZB", "Singularity Core 1048576ZB"]

#shop elements variables 
@onready var currentram: Label = $currentram
@onready var balance: Label = $balance
@onready var buyy: Button = $Buyy
@onready var back: Button = $back

func _ready() -> void:
	update_shop_ui()


func _process(delta: float) -> void:
	balance.text = "balance:" + format_bytes(Global.counter)
	update_shop_ui()

func _on_buyy_pressed() -> void:
	var max_ram_index = names.size() - 1
	
	if Global.counter >= upgrade_cost and Global.RAM_number < max_ram_index:
		Global.counter -= Global.upgrade_cost              # - value
		Global.RAM_number += 1                      # + ram
		Global.multi = float(1 << Global.RAM_number)                        # + mult
		Global.upgrade_cost *= 3.2                         # another step is pricer ( idk if that word exist in english )
		update_shop_ui()
	elif Global.RAM_number >= max_ram_index:
		buyy.text = "MAX LEVEL"
		buyy.disabled = true
	else:
		print("not enought bytes!")

func update_shop_ui() -> void:
	var max_ram_index = names.size() - 1
	
	if Global.RAM_number < names.size():
		currentram.text = "current:   " + names[Global.RAM_number]
	
	if Global.RAM_number >= max_ram_index:
		buyy.text = "MAX LEVEL"
		buyy.disabled = true
	elif Global.counter < Global.upgrade_cost:
		# When player cannot affors
		buyy.text = "not enough bytes!\nprice: " + format_bytes(Global.upgrade_cost)
		buyy.disabled = true # blocked
	else:
		# When player can afford
		buyy.text = "upgrade ram\nprice: " + format_bytes(Global.upgrade_cost)
		buyy.disabled = false # avalible
		
	

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://sceny/main.tscn")

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
