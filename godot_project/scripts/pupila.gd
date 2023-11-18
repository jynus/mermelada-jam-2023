extends Node2D

@export var animation_time : float = 0.5
@export var rotation_speed_degrees : float = 90
@onready var pupila = $Pupila
@onready var circular_sector = $CircularSector

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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

func _on_timer_timeout():
	rotate_pupila(randf_range(-30, 30))
