extends Control

@onready var click : AudioStreamPlayer = $Click

var previous_music : String
var previous_music_offset : float = 0


func _ready():
	visible = false

func _process(delta):
	if visible:
		get_tree().paused = true
		BackgroundMusic.play_song("win")

func unpause():
	visible = false
	get_tree().paused = false

func _on_next_level_pressed():
	var level_select = load("res://scripts/level_select.gd")
	var ls = level_select.new()
	unpause()
	ls.load_next_level(get_tree())

	
func _on_repeat_level_pressed():
	click.play()
	await click.finished
	BackgroundMusic.play_song("pause")
	unpause()
	get_tree().reload_current_scene()



func _on_back_main_menu_pressed():
	click.play()
	await click.finished
	unpause()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

