extends Area2D

@export var speed = 500
@onready var max_distance = 300
@onready var distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	distance += speed * delta
	
	if distance >= max_distance:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	#verifico que el body sea el enemigo
	if body.has_method("recibir_disparo"):
		#hago que reciba el disparo
		
		body.recibir_disparo()
		#lo hago desaparecer
		queue_free()
