extends Area2D

@export var ojos_movement: float = 40
@export var ojos_lag: float = 0.5
@onready var ojos_gatete: Sprite2D = %OjosGatete
@onready var ojos_center = %ojosCenter
@onready var timer = %Timer
@onready var animation_player = %AnimationPlayer
@onready var love_animation = %LoveAnimation
@onready var cat_player = %CatPlayer

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = ojos_lag
	love_animation.color = Globals.COLOR_GOOD

func _on_timer_timeout():
	var direction : Vector2 = (get_global_mouse_position() - ojos_center.global_position).normalized()
	var target_position = ojos_movement * direction
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(ojos_gatete, "position", target_position, ojos_lag)


func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("Yes, you can pet the cat")
		animation_player.speed_scale = 2
		love_animation.emitting = true
		cat_player.play()


func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	animation_player.speed_scale = 1
	love_animation.emitting = false
	cat_player.stop()


func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
