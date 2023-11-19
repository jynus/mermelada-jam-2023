extends Control

@onready var click : AudioStreamPlayer = $Click

func _on_credits_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_back_main_menu_pressed():
	click.play()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
