extends Node2D


@onready var player1 = %PlayerTurret1
@onready var player2 = %PlayerTurret2
@onready var display_x_midpoint : float = get_viewport_rect().size.x / 2
@onready var eyelids = %eyelids

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
	#TODO
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_eyelids_fully_closed():
	game_over()
