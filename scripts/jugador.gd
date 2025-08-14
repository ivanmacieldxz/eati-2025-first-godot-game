extends CharacterBody2D

var speed = 300
@onready var sprite = $Sprite2D
var is_dead = false
var diagonally_orientated = false

func _physics_process(delta: float) -> void:
	if !is_dead:
		if (Input.is_action_just_pressed("disparar")):
			disparar()
			
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
		await get_tree().process_frame
		
		if direction == Vector2.ZERO:
			sprite.pause()
		else:
			diagonally_orientated = direction.x != 0 and direction.y != 0
			if diagonally_orientated:
				sprite.play("walking_diagonally")
			else:
				sprite.play("walking")
			#if Input.is_action_just_pressed("disparar"):
				#disparar_en_movimiento()
		
		velocity = direction * speed
		move_and_slide()
		
		check_collisions()

func disparar():
	const BALA = preload("res://scenes/proyectil.tscn")
	var disparo = BALA.instantiate()
	
	disparo.global_position = global_position
	disparo.look_at(get_global_mouse_position())
	get_parent().add_child(disparo)

func check_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var node_collided = collision.get_collider()
		
		if node_collided.has_method("explode"):
			node_collided.explode()

func get_hit(damage):
	await get_tree().process_frame
	if !is_dead:
		is_dead = true
		if diagonally_orientated:
			sprite.play("death_diagonally")
		else:
			sprite.play("death")
		await sprite.animation_looped
		sprite.frame = 3
		sprite.pause()
