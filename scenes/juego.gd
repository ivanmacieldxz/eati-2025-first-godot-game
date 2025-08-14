extends Node2D

@onready var jugador: CharacterBody2D = $Jugador
@onready var cantidad_enemigos = 4

func _ready():
	crear_ola()

func crear_ola():
	var array_puntos = $PuntosAparicion.get_children()
	for i in range(0, cantidad_enemigos):
		var random_pos = array_puntos.pick_random().global_position
		invocar_enemigo(random_pos)
		await get_tree().create_timer(0.5).timeout

func invocar_enemigo(pos: Vector2):
	const ENEMIGO = preload("res://scenes/enemigo_1.tscn")
	var instancia_enemigo = ENEMIGO.instantiate()
	
	instancia_enemigo.global_position = pos
	instancia_enemigo.target = jugador
	
	instancia_enemigo.enemigo_muerto.connect(check_fin_ola)
	
	$Enemigos.add_child(instancia_enemigo)

func check_fin_ola():
	await get_tree().process_frame
	
	if $Enemigos.get_children().is_empty():
		crear_ola()
