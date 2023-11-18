extends Node2D

@export var eye_rotation_degress: float = 2
@onready var proyectile_spawner = $ProyectileSpawner
var laser_scene: PackedScene = preload("res://scene_objects/proyectile.tscn")
var is_shooting = false


func shoot():
	"""Stop moving and spawn a projectile"""
	print_debug("te pillé")
	is_shooting = true
	var laser: Area2D = laser_scene.instantiate()
	get_parent().add_child(laser)
	laser.global_rotation = proyectile_spawner.global_rotation
	laser.global_position = proyectile_spawner.global_position
	laser.connect("impacted", shoot_finished)

func shoot_finished():
	"""Continue moving"""
	is_shooting = false

func _process(delta):
	if not is_shooting and $RayCast2D.is_colliding():
		shoot()
	
	if not is_shooting:
		rotation += eye_rotation_degress * delta

