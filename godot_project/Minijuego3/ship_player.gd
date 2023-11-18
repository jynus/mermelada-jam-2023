extends Area2D

func _physics_process(delta):
	position = lerp(global_position, get_global_mouse_position(), 2 * delta)


func _on_area_entered(area):
	print("golpeado")
