extends Node2D


@onready var player1 = %PlayerTurret1
@onready var player2 = %PlayerTurret2
@onready var display_x_midpoint : float = get_viewport_rect().size.x / 2
@onready var eyelids = %eyelids
@onready var lose_level = %lose_level
@onready var win_level = %win_level
@onready var win_timer = %WinTimer
@onready var increse_difficulty_timer = %IncreseDifficultyTimer
@onready var torreta_1 = %Torreta1
@onready var torreta_2 = %Torreta2

func _ready():
	BackgroundMusic.play_song("troll")

func _physics_process(delta):
	if Input.is_action_just_pressed("M1"):
		if get_viewport().get_mouse_position().x < display_x_midpoint:
			player1.change_direction()
		else:
			player2.change_direction()

func _on_player_player_hit():
	eyelids.close_eyes(10)

func game_over():
	lose_level.show()

func level_win():
	win_level.show()

func _on_eyelids_fully_closed():
	game_over()

func _on_win_timer_timeout():
	level_win()


func _on_increse_difficulty_timer_timeout():
	if torreta_1.eye_rotation_degress < torreta_2.eye_rotation_degress:
		torreta_1.eye_rotation_degress += 1
	else:
		torreta_2.eye_rotation_degress += 1

