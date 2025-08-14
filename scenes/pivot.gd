extends Node2D

@export var speed = 400
@onready var arma_sprite = $Arma/SpriteArma

func get_input(delta):
	var input_dir = Input.get_axis("down", "up")
	position += transform.x * input_dir * speed * delta

	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	rotation = dir.angle()
	#arma_sprite.rotation = dir.angle()
	# Ángulo en grados normalizado a [-180, 180]
	var angulo = rad_to_deg(rotation)
	angulo = fposmod(angulo + 180, 360) - 180

	

func _physics_process(delta: float) -> void:
	get_input(delta)
	if (Input.is_action_just_pressed("disparar")):
		disparar()


func disparar():
	const BALA = preload("res://scenes/proyectil.tscn")
	var disparo = BALA.instantiate()
	
	disparo.global_position = $Arma/SpriteArma.global_position
	disparo.look_at(get_global_mouse_position())
	get_parent().get_parent().add_child(disparo)
