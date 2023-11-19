extends Node

@export var enemy_scene : PackedScene
@onready var eyelids = $eyelids

var laser = preload("res://assets/sprites/laserBlue08.png")
var cat = preload("res://assets/sprites/huella.png")
@onready var win_level = %win_level
@onready var lose_level = %lose_level

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
	Input.set_custom_mouse_cursor(null)
	lose_level.show()

func level_win():
	win_level.show()

func _on_eyelids_fully_closed():
	game_over()

func _on_win_timer_timeout():
	level_win()
