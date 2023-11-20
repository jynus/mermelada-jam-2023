extends Node2D

@onready var click : AudioStreamPlayer = $Click

var previous_music : String
var previous_music_offset : float = 0

func _ready():
	BackgroundMusic.play_song("win")

func _process(delta):
	pass


func _on_credits_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_back_main_menu_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

