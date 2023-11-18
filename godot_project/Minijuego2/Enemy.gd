extends Area2D

@export var speed = 200

func _physics_process(delta):
	position.x -= speed *delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	print ("se fue")

