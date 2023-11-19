extends Node2D

@export var animation_time : float = 0.5
@export var rotation_speed_degrees : float = 90
@onready var pupila = %Pupila
@onready var circular_sector = %CircularSector
@onready var eyelids = %eyelids
@onready var error_player = %errorPlayer
@onready var danger_area_1: Sprite2D = %DangerArea1
@onready var danger_area_2: Sprite2D = %DangerArea2
@onready var good_area_sprite: Sprite2D = %GoodAreaSprite
@onready var outside_timer = %OutsideTimer

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	BackgroundMusic.play_song("troll")
	good_area_sprite.self_modulate = Globals.COLOR_GOOD
	danger_area_1.self_modulate = Globals.COLOR_BAD
	danger_area_2.self_modulate = Globals.COLOR_BAD

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("M1"):
		circular_sector.rotation_degrees += rotation_speed_degrees * delta
	else:
		circular_sector.rotation_degrees -= rotation_speed_degrees * delta

func rotate_pupila(angle: float):
	"""Rotates the pupil the given amount, in degrees"""
	if tween:
		tween.kill()
	tween = create_tween()
	var target_degrees: float = pupila.rotation_degrees + angle
	tween.tween_property(pupila, "rotation_degrees", target_degrees, animation_time).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

func _on_random_movement_timer_timeout():
	rotate_pupila(randf_range(-30, 30))

func outside():
	outside_timer.start()
	error_player.play()
	eyelids.close_eyes(20)
	

func inside():
	outside_timer.stop()

func _on_keep_area_area_exited(area):
	"""Error when exiting the safe area"""
	outside()

func _on_keep_area_area_entered(area):
	"""Back to ok when entering the area"""
	inside()

func _on_outside_timer_timeout():
	"""Error when staying on the bad area for long"""
	outside()

func game_over():
	# TODO
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_eyelids_fully_closed():
	game_over()
