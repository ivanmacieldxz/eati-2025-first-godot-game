extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var enemies_count = 4

func _ready():
	var spawn_points = $SpawnPoints.get_children()
	
	for i in range(0, enemies_count):
		await get_tree().create_timer(0.5).timeout
		var random_pos = spawn_points.pick_random().global_position
		invoke_enemy(random_pos)

func invoke_enemy(pos: Vector2):
	const ENEMY = preload("res://scenes/enemigo_1.tscn")
	var enemy_instance = ENEMY.instantiate()
	
	enemy_instance.global_position = pos
	enemy_instance.target = player
	
	add_child(enemy_instance)
