extends Node2D

class_name Player4

@onready var timer = $Timer

signal player_hit
var stopped: bool = false

@onready var path : PathFollow2D = $Path2D/PathFollow2D
@export var speed = 0.15

func _process(delta):
	if not stopped:
		var progress = clamp(path.progress_ratio + speed * delta, 0, 1)
		if progress == 0 or progress == 1:
			stopped = true
		path.progress_ratio = progress

func change_direction():
	speed = -speed
	stopped = false
	#timer.wait_time = randi_range(2, 7)
	#timer.start()

func _on_area_2d_area_entered(area):
	player_hit.emit()

func _on_timer_timeout():
	stopped = true
