extends Area2D

class_name Colirio

@export var speed : float = 200
@onready var sprite : Sprite2D = %Sprite
@onready var despawn_line : float
@onready var destroy_timer = %DestroyTimer
@onready var collision = %Collision
@onready var particle_effect = %ParticleEffect
@onready var color = Globals.COLOR_GOOD
var alive: bool = true

signal missed
signal touched

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.self_modulate = color
	update_despawn_area()
	get_tree().root.size_changed.connect(update_despawn_area)
	
func update_despawn_area():
	despawn_line = get_viewport().get_visible_rect().size.y + sprite.texture.get_height()

func despawn():
	alive = false
	missed.emit()
	collision.set_deferred("disabled", true)
	sprite.hide()
	particle_effect.color = Globals.COLOR_BAD
	particle_effect.emitting = true
	destroy_timer.start()

func colirio_touched():
	alive = false
	touched.emit()
	collision.set_deferred("disabled", true)
	sprite.hide()
	destroy_timer.start()
	particle_effect.color = Globals.COLOR_GOOD
	particle_effect.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# fall
	position.y += speed * delta

	# despawn
	if position.y > despawn_line and alive:
		despawn()

func _on_area_entered(area):
	colirio_touched()


func _on_destroy_timer_timeout():
	queue_free()
