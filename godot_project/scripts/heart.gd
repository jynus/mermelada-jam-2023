extends Area2D

@export var speed : float = -200
@onready var sprite : Sprite2D = $Sprite
@onready var color = Globals.COLOR_GOOD
var cat = preload("res://assets/sprites/huella_gato.png")
@onready var clicked_effect = %ClickedEffect
@onready var destroy_timer = %DestroyTimer
@onready var collision = %Collision

signal missed
signal touched

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.self_modulate = color
	clicked_effect.color = color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func click_heart():
	collision.set_deferred("disabled", true)
	print("Clicked")
	$DespawnTimer.paused = true
	clicked_effect.emitting = true
	sprite.hide()
	$CollisionPolygon2D.disabled = true
	$AudioStreamPlayer.play()
	destroy_timer.start()

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		click_heart()

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(cat)


func _on_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_despawn_timer_timeout():
	clicked_effect.color = Globals.COLOR_BAD
	clicked_effect.emitting = true
	sprite.hide()
	collision.set_deferred("disabled", true)
	missed.emit()
	destroy_timer.start()

func _on_destroy_timer_timeout():
	queue_free()
