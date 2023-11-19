extends Control

@onready var click : AudioStreamPlayer = $Click

var previous_music : String
var previous_music_offset : float = 0


func _ready():
	visible = false

func _process(delta):
	if visible:
		get_tree().paused = true
		previous_music = BackgroundMusic.current_song
		previous_music_offset = BackgroundMusic.stop()

func unpaused():
	get_tree().paused = false

func _on_next_level_pressed():
	pass

	
func _on_repeat_level_pressed():
	click.play()
	await click.finished
	BackgroundMusic.play_song("pause")
	unpaused()
	get_tree().reload_current_scene()



func _on_back_main_menu_pressed():
	click.play()
	await click.finished
	unpaused()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

