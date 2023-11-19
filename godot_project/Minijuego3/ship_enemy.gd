extends RigidBody2D

func _process(delta):
	pass

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()



func _on_button_button_down():
	hide()
