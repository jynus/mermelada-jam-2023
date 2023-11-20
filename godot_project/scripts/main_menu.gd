extends Node2D

@onready var exit_button : Button = %ExitButton
@onready var play_button : Button = $menuContainer/optionsContainer/buttonsContainer/PlayButton
@onready var blip : AudioStreamPlayer = $blip
@onready var settings := $settings
@onready var laser = preload("res://assets/sprites/puntero_laser.png")

var laser_disabled: bool = false
var cursor_laser : bool = false

func _init():
	# Load settings config
	var user_settings = UserSettings.new()
	user_settings.load_settings()

func _ready():
	# Disable exit button if we are on the web
	if OS.get_name() == "Web":
		exit_button.hide()
	if Input.get_connected_joypads().size() > 0:
		play_button.grab_focus()
	BackgroundMusic.play_song("menu")
	# show gatete only on root main menu
	$"backgroudMenu/Gatete".show()

func _process(_delta):
	if not laser_disabled:
		if cursor_laser and get_global_mouse_position().x > 1200:
			Input.set_custom_mouse_cursor(null)
			cursor_laser = false
		elif not cursor_laser and get_global_mouse_position().x <= 1200:
			Input.set_custom_mouse_cursor(laser)
			cursor_laser = true

func show_settings():
	"""Show the settings screen"""
	settings.visible = true

func show_credits():
	"""Show the credits screen"""
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_settings_button_pressed():
	"""Show the settings menu"""
	blip.play()
	laser_disabled = true
	Input.set_custom_mouse_cursor(null)
	show_settings()

func exit_game():
	""""Exit to OS"""
	get_tree().quit()

func start_new_game():
	"""Start new play session"""
	Input.set_custom_mouse_cursor(null)
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_credits_button_pressed():
	blip.play()
	await blip.finished
	Input.set_custom_mouse_cursor(null)
	show_credits()

func _on_exit_button_pressed():
	blip.play()
	await blip.finished
	exit_game()


func _on_play_button_pressed():
	blip.play()
	await blip.finished
	Input.set_custom_mouse_cursor(null)
	start_new_game()


func _on_fly_collision_mouse_entered():
	if not laser_disabled:
		%ParticleEffect.color = Globals.COLOR_BAD
		%ParticleEffect.emitting = true
		%MoscaEnemigo1.self_modulate = Color.TRANSPARENT
		%flydeath.play()
		await %flydeath.finished
		%MoscaEnemigo1.queue_free()

func _on_settings_visibility_changed():
	if not $settings.visible:
		laser_disabled = false
		Input.set_custom_mouse_cursor(laser)

