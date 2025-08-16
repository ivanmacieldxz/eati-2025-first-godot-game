extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var enemies_count = 5

func _ready():
	player.dead_player.connect(game_over)
	player.player_hurt.connect($HUD.update_lives_label)
	Global.reset_player_hp()
	$HUD.update_lives_label()
	invoke_enemy_wave()


func invoke_enemy_wave():
	if !player.dead:
		Global.inc_wave()
		$HUD.update_wave_count_label()
		
		var spawn_points = $SpawnPoints.get_children()
		
		for i in range(0, enemies_count):
			await get_tree().create_timer(0.5).timeout
			var random_pos = spawn_points.pick_random().global_position
			invoke_enemy(random_pos)
		
		enemies_count = enemies_count + enemies_count / 2

func invoke_enemy(pos: Vector2):
	const ENEMY = preload("res://scenes/enemigo_1.tscn")
	var enemy_instance = ENEMY.instantiate()
	
	enemy_instance.global_position = pos
	enemy_instance.target = player
	
	enemy_instance.dead_enemy.connect(check_wave_end)
	
	$Enemies.add_child(enemy_instance)

func check_wave_end():
	await get_tree().process_frame
	print(enemies_count)
	if ($Enemies.get_children().is_empty()):
		invoke_enemy_wave()


func game_over():
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
