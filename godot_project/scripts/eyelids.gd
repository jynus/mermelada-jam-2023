extends Node2D

class_name Eyelids

signal fully_closed

@export var percentage_eyelid_closed : float = 0
@export var time_to_close_fully : float = 20
@onready var upper_eyelid = $upper_eyelid
@onready var lower_eyelid = $lower_eyelid

@onready var original_pos_upper: float = upper_eyelid.position.y
@onready var original_pos_lower: float = lower_eyelid.position.y

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func close_eyes(amount: float = 10):
	"""Closes eyelids for some amount, from 0 to 100, in percentage"""
	percentage_eyelid_closed = clamp(percentage_eyelid_closed + amount, 0, 100)
	if percentage_eyelid_closed == 100:
		fully_closed.emit()
	var animation_time : float = time_to_close_fully / 100 * amount
	var target_upper = original_pos_upper - original_pos_upper / 100 * percentage_eyelid_closed
	var target_lower = original_pos_lower - (target_upper - original_pos_upper)
	if tween:
		tween.kill()
	tween = create_tween()
	if tween != null:
		tween.set_parallel(true)
		tween.tween_property(upper_eyelid, "position:y", target_upper, animation_time).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(lower_eyelid, "position:y", target_lower, animation_time).set_trans(Tween.TRANS_BOUNCE)
