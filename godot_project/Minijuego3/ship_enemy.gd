extends RigidBody2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var color = Globals.COLOR_BAD

func _ready():
	sprite.self_modulate = color

func _process(delta):
	pass


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_button_button_down():
	hide()
