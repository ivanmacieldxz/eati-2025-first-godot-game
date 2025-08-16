extends CharacterBody2D

var speed = 300
var moving = false
@onready var animated_sprite = $AnimatedSprite2D
@export var dead: bool = false


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("disparar"):
		shoot()
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	moving = velocity != Vector2.ZERO
	
	change_moving_animation()
	animated_sprite.play(animated_sprite.animation)
	
	move_and_slide()
	
func change_moving_animation():
	var moving_diagonally = velocity.x != 0 and velocity.y != 0
	
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
	shot.look_at(get_global_mouse_position())
	
	get_parent().add_child(shot)
	
