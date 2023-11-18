extends Node

@export var enemy_scene : PackedScene




func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = get_node("Path_enemy/PathFollow2D")
	enemy_spawn_location.progress_ratio = randf()
	var player_position = $Ship_player.position
	enemy.initialize(enemy_spawn_location.position, player_position)
	
	add_child(enemy)
	print("aaa")
