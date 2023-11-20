extends Node2D

@onready var timer = $Timer
@onready var sprite : Sprite2D = $Path2D/PathFollow2D/Area2D/Sprite2D

signal player_hit
var stopped: bool = false

@onready var path : PathFollow2D = $Path2D/PathFollow2D
@onready var hurt_sound = %HurtSound
@export var speed: float = 0.15
@onready var particle_effect = %ParticleEffect

func _ready():
	sprite.self_modulate = Globals.COLOR_GOOD
	particle_effect.color = Globals.COLOR_BAD

func _process(delta):
	if not stopped:
		path.progress_ratio = path.progress_ratio + speed * delta

func change_direction():
	speed = -speed
	stopped = false
	timer.wait_time = randi_range(2, 7)
	timer.start()

func _on_area_2d_area_entered(area):
	hurt_sound.play()
	particle_effect.emitting = true
	player_hit.emit()

func _on_timer_timeout():
	stopped = true
