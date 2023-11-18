extends RigidBody2D

#@export var speed : float = randf_range(150.0, 300.0)



func _process(delta):
	pass

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
