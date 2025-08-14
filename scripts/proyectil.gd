extends Area2D

@export var velocidad = 500
@onready var recorrido_max = 300
@onready var distancia = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * velocidad * delta
	distancia += velocidad * delta
	
	if distancia >= recorrido_max:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	#verifico que el body sea el enemigo
	if body.has_method("recibir_disparo"):
		#hago que reciba el disparo
		
		body.recibir_disparo()
		#lo hago desaparecer
		queue_free()
