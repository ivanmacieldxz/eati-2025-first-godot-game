extends CharacterBody2D

var speed = 300
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("disparar")):
		disparar()
		
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	await get_tree().process_frame
	
	if direction == Vector2.ZERO:
		sprite.pause()
	else:
		if direction.x != 0 and direction.y != 0:
			sprite.play("walking_diagonally")
		else:
			sprite.play("walking")
		#if Input.is_action_just_pressed("disparar"):
			#disparar_en_movimiento()
	
	velocity = direction * speed
	move_and_slide()

func disparar():
	const BALA = preload("res://scenes/proyectil.tscn")
	var disparo = BALA.instantiate()
	
	disparo.global_position = global_position
	disparo.look_at(get_global_mouse_position())
	get_parent().add_child(disparo)
	
