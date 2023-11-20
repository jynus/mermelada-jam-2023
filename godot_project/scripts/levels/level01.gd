extends Node2D

var heart_scene : PackedScene = preload("res://scene_objects/heart.tscn")

@onready var display_x_midpoint : float = get_viewport_rect().size.x / 2
@onready var eyelids = %eyelids
@onready var spawn_timer = %SpawnTimer
@onready var win_level = %winLevel
@onready var lose_level = %lose_level
@onready var spawn_effect = %SpawnEffect
@onready var missed_effect = %MissedEffect

@export var eyes_close_pct_on_hit: float = 5
func _ready():
	BackgroundMusic.play_song("cute")

func spawn_heart():
	var heart = heart_scene.instantiate()
	var sprite : Sprite2D = heart.get_node("Sprite")
	var heart_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())
	get_node("hearts").add_child(heart)
	heart.position = Vector2(randi_range(heart_size.x / 2, get_viewport_rect().size.x - heart_size.x / 2),
							 randi_range(heart_size.y / 2, get_viewport_rect().size.y - heart_size.y / 2))
	heart.connect("missed", heart_missed)
	spawn_effect.play()

func heart_missed():
	eyelids.close_eyes(5)
	missed_effect.play()

func _on_spawn_timer_timeout():
	spawn_heart()

func level_win():
	Input.set_custom_mouse_cursor(null)
	win_level.show()

func _on_win_timer_timeout():
	level_win()

func game_over():
	Input.set_custom_mouse_cursor(null)
	lose_level.show()

func _on_eyelids_fully_closed():
	game_over()


func _on_increase_difficulty_timer_timeout():
	spawn_timer.wait_time /= 1.3
