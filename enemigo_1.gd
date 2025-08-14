extends CharacterBody2D

@onready var vidas = 1
@onready var speed = 300
var target
@onready var sprite = $AnimatedSprite2D

signal enemigo_muerto

func recibir_disparo():
	vidas -= 1
	if vidas == 0:
		enemigo_muerto.emit()
		queue_free()

func _physics_process(delta: float) -> void:
	if target:
		var direction = (target.global_position - global_position).normalized()
		
		sprite.play()
		
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
		
		
		velocity = speed * direction
		move_and_slide()
		
		await check_collisions()
		
func check_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var node_collided = collision.get_collider()
		
		if node_collided.name == "Jugador":
			sprite.animation = "exploding"
			await sprite.animation_looped
			queue_free()
