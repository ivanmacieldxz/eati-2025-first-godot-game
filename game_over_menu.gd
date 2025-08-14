extends Control
@onready var label_mod = $Panel/Label2

func _ready() -> void: 
	label_mod.text = "Has superado "+str(Global.get_wave_count() - 1)+ " oleadas"
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/juego.tscn")
