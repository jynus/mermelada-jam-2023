extends Node2D

@onready var blip : AudioStreamPlayer = $blip

@onready var done_button : Button = %doneButton

func _ready():
	BackgroundMusic.play_song("menu")
	if Input.get_connected_joypads().size() > 0:
		done_button.grab_focus()

func _process(_delta):
	pass

func return_to_main_menu():
	"""Go back to main menu screen"""
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_done_button_pressed():
	blip.play()
	await blip.finished
	return_to_main_menu()

func open_web_browser(url: String):
	"""
	Opens the system web browser (or another tab, if on web) with
	the given url link
	"""
	OS.shell_open(url)

func _on_twitter_button_pressed():
	blip.play()
	open_web_browser("https://twitter.com/Eolohh")

func _on_twitter_button_2_pressed():
	blip.play()
	open_web_browser("https://www.instagram.com/montes8ish")

func _on_itchio_button_pressed():
	blip.play()
	open_web_browser("https://soundcloud.com/moogge")

func _on_web_button_pressed():
	blip.play()
	open_web_browser("https://jynus.itch.io")



