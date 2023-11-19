extends Node2D

var heart_scene : PackedScene = preload("res://scene_objects/heart.tscn")

@onready var display_x_midpoint : float = get_viewport_rect().size.x / 2
@onready var eyelids = %eyelids
@onready var pickup_effect = %PickupEffect
@onready var spawn_timer = %SpawnTimer
@onready var win_level = %winLevel

@export var eyes_close_pct_on_hit: float = 5
func _ready():
	BackgroundMusic.play_song("cute")

func _on_player_player_hit():
	pickup_effect.play()

func spawn_heart():
	var heart = heart_scene.instantiate()
	var sprite : Sprite2D = heart.get_node("Sprite")
	var heart_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())
	get_node("hearts").add_child(heart)
	heart.position = Vector2(randi_range(heart_size.x, get_viewport_rect().size.x - heart_size.x),
							 randi_range(heart_size.y, get_viewport_rect().size.y - heart_size.y))

func _on_spawn_timer_timeout():
	spawn_heart()

func level_win():
	win_level.show()

func _on_win_timer_timeout():
	level_win()
