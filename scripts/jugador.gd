extends CharacterBody2D

signal game_over 

var speed = 300
@onready var sprite = $Sprite2D
@export var daño_por_frame = 1
var enemigos_en_hurtbox = []

var is_dead = false
var diagonally_orientated = false
	
	
func _physics_process(delta: float) -> void:
	print("Vida: "+str(Global.vida))
	if not enemigos_en_hurtbox.is_empty():
		recibir_daño()
	if !is_dead:	
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
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

func check_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var node_collided = collision.get_collider()
		
		if node_collided.has_method("explode"):
			node_collided.explode()

#func get_hit(damage):
	#print("was called")
	#await get_tree().process_frame
	#if !is_dead:
		#print("got here")
		#is_dead = true
		#if diagonally_orientated:
			#sprite.play("death_diagonally")
			#print("changed sprite to diagonal1")
		#else:
			#print("changed sprite to normal death")
			#sprite.play("death")
			#
		#await sprite.animation_looped
		#sprite.frame = 3
		#sprite.pause()
		#print("did die")
		#
func recibir_daño(): 
	Global.update_vida(enemigos_en_hurtbox.size() * daño_por_frame)
	if Global.vida <= 0:
		game_over.emit()
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.has_method("recibir_disparo"):
		if not body in enemigos_en_hurtbox:
			enemigos_en_hurtbox.append(body)
	
func _on_hurtbox_body_exited(body: Node2D) -> void:
	if body in enemigos_en_hurtbox:
		enemigos_en_hurtbox.erase(body)
