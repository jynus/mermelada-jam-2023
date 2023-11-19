extends Node

@export var enemy_scene : PackedScene
@onready var eyelids = $eyelids

var laser = preload("res://assets/sprites/laserBlue08.png")
var cat = preload("res://assets/sprites/huella.png")

func _ready():
	Input.set_custom_mouse_cursor(laser)

func _physics_process(_delta):
	pass

func _on_enemy_timer_timeout():
	var enemy_spawn_location = $Path2D/PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	
	enemy.position = enemy_spawn_location.position
	
	var direction = enemy_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	
	var velocity = Vector2(randf_range(400.0, 800.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)


func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("M1"):
		Input.set_custom_mouse_cursor(cat)
		$laser_cat.play()

	elif event is InputEventMouseButton and event.is_action_released("M1"):
		Input.set_custom_mouse_cursor(laser)


func _on_ship_player_player_hit():
	eyelids.close_eyes(5)

func game_over():
	#TODO
	Input.set_custom_mouse_cursor(null)
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_eyelids_fully_closed():
	game_over()
