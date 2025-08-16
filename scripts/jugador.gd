extends CharacterBody2D

var speed = 100
var moving = false
@onready var animated_sprite = $AnimatedSprite2D
@export var dead: bool = false
var vida = 100
var moving_diagonally = false

func _physics_process(delta: float) -> void:
	if !dead:
		if Input.is_action_just_pressed("disparar"):
			shoot()
	
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed
		moving = velocity != Vector2.ZERO
		
		change_moving_animation()
		animated_sprite.play(animated_sprite.animation)
		
		move_and_slide()
	
func change_moving_animation():
	moving_diagonally = velocity.x != 0 and velocity.y != 0
	
	if moving_diagonally:
		animated_sprite.animation = "walking_diagonally"
	else:
		animated_sprite.animation = "walking"

func shoot():
	const BULLET = preload("res://scenes/proyectil.tscn")
	var shot = BULLET.instantiate()
	
	if moving:
		shot.imprecise = true
	
	shot.global_position = get_node("Pivot/Gun/BarrelEnd").global_position
	shot.rotation = $Pivot.rotation
	
	get_parent().add_child(shot)
	
func get_hurt():
	vida -= 10
	if vida == 0:
		dead = true
		if moving_diagonally:
			animated_sprite.animation = "death"
		else:
			animated_sprite.animation = "death_diagonally"
		
		animated_sprite.sprite_frames.set_animation_loop(animated_sprite.animation, false)
		await animated_sprite.animation_finished
