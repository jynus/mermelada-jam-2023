extends Node2D
var heart_scene : PackedScene = preload("res://Minijuego5/heart.tscn")

@onready var display_x_midpoint : float = get_viewport_rect().size.x / 2
@onready var eyelids = $eyelids

@export var eyes_close_pct_on_hit: float = 5
func _ready():
	print_debug("midpoint: ", display_x_midpoint)

func _physics_process(delta):
	pass

func _on_player_player_hit():
	$AudioStreamPlayer.play()

func spawn_heart():
	var heart = heart_scene.instantiate()
	var sprite : Sprite2D = heart.get_node("Sprite")
	var heart_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())
	get_parent().add_child(heart)
	heart.position = Vector2(randi_range(heart_size.x, get_viewport_rect().size.x - heart_size.x),
							 randi_range(heart_size.y, get_viewport_rect().size.y - heart_size.y))

func _on_timer_timeout():
	spawn_heart()
