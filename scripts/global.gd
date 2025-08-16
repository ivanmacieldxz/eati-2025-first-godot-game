extends Node

@onready var wave_number = 0
var player_hp = 3

func inc_wave():
	wave_number += 1

func reset_wave():
	wave_number = 0

func reset_player_hp():
	player_hp = 3
