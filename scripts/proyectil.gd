extends Area2D

@export var speed = 500
@onready var max_distance = 300
@onready var distance = 0
var imprecise = false
@export var imprecision_range = 30

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	
	if (imprecise):
		direction = direction.rotated(
			deg_to_rad(
				RandomNumberGenerator.new().randf_range(-imprecision_range, imprecision_range)
			)
		)
		imprecise = false
	
	position += direction * speed * delta
	distance += speed * delta
	
	if distance >= max_distance:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	#verifico que el body sea el enemigo
	if body.has_method("get_shot"):
		#hago que reciba el disparo
		body.get_shot()
		#lo hago desaparecer
		queue_free()
