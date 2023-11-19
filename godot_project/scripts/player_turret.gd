extends Node2D

@onready var timer = $Timer

signal player_hit
var stopped: bool = false

@onready var path : PathFollow2D = $Path2D/PathFollow2D
@export var speed: float = 0.15

func _process(delta):
	if not stopped:
		path.progress_ratio = path.progress_ratio + speed * delta

func change_direction():
	speed = -speed
	stopped = false
	timer.wait_time = randi_range(2, 7)
	timer.start()

func _on_area_2d_area_entered(area):
	player_hit.emit()

func _on_timer_timeout():
	stopped = true
