extends Control

@onready var click : AudioStreamPlayer = $Click
@onready var load_level_button : PackedScene = preload("res://scene_objects/level_button.tscn")
@export var current_level : String


const levels_path : String = "res://levels"
var levels : Dictionary
var LEVELS_FILE_PATH : String = "user://levels.cfg"
@export var current_world : String


func _ready():
	visible = false


func _on_next_level_pressed():
	pass
	"""
	currentLevel = levels[0]
	printerr("next level: ", levels_directory + currentLevel)
	get_tree().change_scene_to_file(levels_directory + currentLevel)
	"""

func _on_repeat_level_pressed():
	click.play()
	await click.finished
	get_tree().reload_current_scene()


func _on_back_main_menu_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
