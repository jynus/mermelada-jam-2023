extends Area2D

@export var speed : float = -200
@onready var sprite : Sprite2D = $Sprite
@onready var color = Globals.COLOR_GOOD

signal missed
signal touched

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.self_modulate = color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	touched.emit()
	queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")
		hide()
		$AudioStreamPlayer.play()

func _on_audio_stream_player_finished():
	queue_free()


func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
