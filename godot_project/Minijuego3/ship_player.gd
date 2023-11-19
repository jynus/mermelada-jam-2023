extends Area2D
signal player_hit

func _physics_process(delta):
	position = lerp(global_position, get_global_mouse_position(), 2 * delta)


func _on_body_entered(body):
	player_hit.emit()
	print("aaaa")
