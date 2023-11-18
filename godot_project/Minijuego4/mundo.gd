extends Node2D

@onready var player: Player4 = $Player
@onready var display_x_midpoint : float = get_viewport_rect().size.x / 2
@onready var eyelids = $eyelids

@export var eyes_close_pct_on_hit: float = 5
func _ready():
	print_debug("midpoint: ", display_x_midpoint)

func _physics_process(delta):
	if Input.is_action_just_pressed("M1"):
		player.change_direction()


func _on_player_player_hit():
	$AudioStreamPlayer.play()

