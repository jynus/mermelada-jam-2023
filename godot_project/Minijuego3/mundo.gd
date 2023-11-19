extends Node

@export var enemy_scene : PackedScene
@onready var eyelids = $eyelids

var laser = load("res://Minijuego3/laserBlue08.png")
var cat = load("res://Minijuego3/huella.png")

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
