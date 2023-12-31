extends Control

@onready var click : AudioStreamPlayer = $Click
@onready var next_level = %next_level
@onready var repeat_level = %Repeat_level
@onready var back_main_menu = %back_main_menu
@onready var enable_buttons_timer = %EnableButtonsTimer
@onready var win_fx = %WinFX

var previous_music : String
var previous_music_offset : float = 0
var previous_music_level : float
var was_visible : bool = false

func _ready():
	visible = false

func _process(delta):
	if not was_visible and visible:
		was_visible = true
		enable_buttons_timer.start()
		get_tree().paused = true
		previous_music_level = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music"))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), -15)
		BackgroundMusic.play_song("win")
		win_fx.play()

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

func _on_enable_buttons_timer_timeout():
	next_level.disabled = false
	repeat_level.disabled = false
	back_main_menu.disabled = false


func _on_win_fx_finished():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), previous_music_level)
