extends Node
@onready var wave_number = 1
@onready var vida = 100
signal player_damaged 
signal wave_win

func inc_wave():
	wave_number+=1
	wave_win.emit()

func reset_wave():
	wave_number = 1

func get_wave_count():
	return wave_number

func update_vida(Daño: int):
	vida -= Daño
	player_damaged.emit()
