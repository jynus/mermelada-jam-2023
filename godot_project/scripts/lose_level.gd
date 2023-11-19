extends Control

@onready var click : AudioStreamPlayer = $Click

func _ready():
	visible = true

func _on_repeat_level_pressed():
	click.play()
	await click.finished
	get_tree().reload_current_scene()

func _on_back_main_menu_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
