extends CharacterBody2D

var speed = 50
var hp = 1
var target
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

signal dead_enemy

func _ready():
	sprite.animation = "walking"

func _physics_process(delta: float) -> void:
	if target:
		sprite.play(sprite.animation)
		var direction = (target.global_position - global_position).normalized()
		
		sprite.flip_h = direction.x < 0;
		
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision and collision.get_collider() == target:
			target.get_hurt()
			explode()


func get_shot():
	hp -= 1
	if hp == 0:
		explode()

func explode():
	target = null
	remove_child(collision_shape)
	sprite.animation = "exploding"
	sprite.speed_scale = 2
	await sprite.animation_looped
	dead_enemy.emit()
	queue_free()
