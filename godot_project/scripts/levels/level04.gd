extends Node2D


@onready var player1 = %PlayerTurret1
@onready var player2 = %PlayerTurret2
@onready var display_x_midpoint : float = get_viewport_rect().size.x / 2
@onready var eyelids = %eyelids
@onready var lose_level = %lose_level
@onready var win_level = %win_level
@onready var win_timer = %WinTimer

func _ready():
	BackgroundMusic.play_song("troll")

func _physics_process(delta):
	if Input.is_action_just_pressed("M1"):
		if get_viewport().get_mouse_position().x < display_x_midpoint:
			player1.change_direction()
		else:
			player2.change_direction()

func _on_player_player_hit():
	eyelids.close_eyes(5)

func game_over():
	lose_level.show()

func level_win():
	win_level.show()

func _on_eyelids_fully_closed():
	game_over()

func _on_win_timer_timeout():
	level_win()
