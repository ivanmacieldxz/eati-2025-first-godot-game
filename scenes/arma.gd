extends Node2D

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("disparar")):
		disparar()


func disparar():
	const BALA = preload("res://scenes/proyectil.tscn")
	var disparo = BALA.instantiate()
	
	disparo.global_position = global_position
	disparo.look_at(get_global_mouse_position())
	get_parent().get_parent().get_parent().add_child(disparo)
