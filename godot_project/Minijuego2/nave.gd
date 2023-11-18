extends Area2D

class_name Player
const speed = 200


func _process(delta):
	if Input.is_action_pressed("M1"):
		position.y += speed * delta
	else :
		position.y -= speed * delta
