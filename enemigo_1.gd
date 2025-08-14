extends CharacterBody2D

@onready var vidas = 1
@onready var speed = 100
var target
@onready var sprite = $AnimatedSprite2D

signal enemigo_muerto

func recibir_disparo():
	vidas -= 1
	if vidas == 0:
		queue_free()
		enemigo_muerto.emit()

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
		
func explode():
	target = null
	$CollisionShape2D.disabled = true
	sprite.animation = "exploding"
	await sprite.animation_looped
	queue_free()
	enemigo_muerto.emit()
