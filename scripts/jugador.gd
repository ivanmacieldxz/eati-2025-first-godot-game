extends CharacterBody2D

var speed = 75
var moving = false
@onready var animated_sprite = $AnimatedSprite2D
@export var dead: bool = false
var moving_diagonally = false
@onready var camera = $Camera2D

signal dead_player
signal player_hurt

func _ready():
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 1152
	camera.limit_bottom = 648
	camera.limit_smoothed = true

func _physics_process(delta: float) -> void:
	if !dead:
		if Input.is_action_just_pressed("disparar"):
			shoot()
	
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed
		moving = velocity != Vector2.ZERO
		
		
		
		if moving:
			change_moving_animation()
			animated_sprite.play(animated_sprite.animation)
		
			move_and_slide()
		else:
			animated_sprite.pause()
	
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
	Global.player_hp -= 1
	
	if Global.player_hp >= 0:
		player_hurt.emit()
	
	if Global.player_hp == 0:
		dead = true
		if !moving_diagonally:
			animated_sprite.animation = "death"
		else:
			animated_sprite.animation = "death_diagonally"
		
		if !moving:
			animated_sprite.play()
		
		animated_sprite.sprite_frames.set_animation_loop(animated_sprite.animation, false)
		await animated_sprite.animation_finished
		dead_player.emit()
