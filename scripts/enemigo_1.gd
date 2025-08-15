extends CharacterBody2D

var speed = 250
var hp = 1
var target


func _physics_process(delta: float) -> void:
	if target:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_collide(velocity * delta)

 
