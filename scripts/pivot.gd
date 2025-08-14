extends Node2D

@export var speed = 400
@onready var arma_sprite = $Arma/SpriteArma

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if (Input.is_action_just_pressed("disparar")):
		disparar()

func reproducir_sonido_disparo():
	var sonido = $Arma/Sonido
	add_child(sonido)
	sonido.play()

func disparar():
	const BALA = preload("res://scenes/proyectil.tscn")
	var disparo = BALA.instantiate()
	disparo.global_position = arma_sprite.global_position
	disparo.look_at(get_global_mouse_position())
	get_parent().get_parent().add_child(disparo)
	reproducir_sonido_disparo()
