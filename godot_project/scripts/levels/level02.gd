extends Node2D

@export var miss_penalty: float = 10
var spawn_object_level : PackedScene = preload("res://scene_objects/colirio.tscn")
@onready var player = %Player
@onready var pickup_effect = %PickupEffect
@onready var spawn_limit_left = %spawnLimitLeft
@onready var spawn_limit_right = %spawnLimitRight
@onready var miss_effect = %MissEffect
@onready var eyelids: Eyelids = %eyelids

# Called when the node enters the scene tree for the first time.
func _ready():
	BackgroundMusic.play_song("cute")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("M1"):
		player.change_direction()

func spawn_object():
	var object: Colirio = spawn_object_level.instantiate()
	var sprite : Sprite2D = object.get_node("Sprite")
	var size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())
	get_parent().add_child(object)
	object.global_position = Vector2(randi_range(spawn_limit_left.position.x + size.x / 2,
												 spawn_limit_right.position.x - size.x / 2),
									 -size.y)
	object.missed.connect(colirio_missed)

func colirio_missed():
	miss_effect.play()
	eyelids.close_eyes(miss_penalty)

func _on_spawn_timer_timeout():
	spawn_object()


func _on_player_player_hit():
	pickup_effect.play()

func game_over():
	# FIXME: show game over screen, pause, music, etc
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_eyelids_fully_closed():
	game_over()
