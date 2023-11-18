extends Node2D

@export var speed = 0.15

func _process(delta):
	if Input.is_action_pressed("M1"):
		$Path2D/PathFollow2D.progress_ratio += speed * delta

	else:
		$Path2D/PathFollow2D.progress_ratio -= speed * delta
