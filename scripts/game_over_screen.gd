extends Control

@onready var wave_count_label = $Panel/WaveCountLabel

func _ready():
	wave_count_label.text = str(Global.wave_number - 1) + " waves survived."

func _on_play_again_button_pressed() -> void:
	Global.reset_wave()
	get_tree().change_scene_to_file("res://scenes/juego.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
