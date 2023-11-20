extends Control

@onready var click : AudioStreamPlayer = $Click
@onready var repeat_level : Button = %Repeat_level
@onready var back_main_menu : Button = %back_main_menu
@onready var enable_buttons_timer = %EnableButtonsTimer
@onready var lose_fx = %LoseFX

var previous_music : String
var previous_music_offset : float = 0
var previous_music_level : float
var was_visible : bool = false

func _ready():
	visible = false

func _process(delta):
	if not was_visible and visible:
		was_visible = true
		get_tree().paused = true
		enable_buttons_timer.start()
		previous_music_level = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music"))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), -15)
		BackgroundMusic.play_song("lose")
		lose_fx.play()

func unpause():
	get_tree().paused = false

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
	repeat_level.disabled = false
	back_main_menu.disabled = false


func _on_lose_fx_finished():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), previous_music_level)
