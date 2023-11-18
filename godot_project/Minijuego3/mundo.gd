extends Node

@export var enemy_scene : PackedScene

func _ready():
	pass

func _physics_process(delta):
	pass

func _on_enemy_timer_timeout():
	var enemy_spawn_location = $Path2D/PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	
	enemy.position = enemy_spawn_location.position
	
	var direction = enemy_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	
	var velocity = Vector2(randf_range(400.0, 800.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)
