extends Node2D

@export var eye_rotation_degress: float = 2
@onready var eye = $Sprite2D


func _process(delta):
	eye.rotation += eye_rotation_degress * delta
	$RayCast2D.rotation += eye_rotation_degress * delta
	
	if $RayCast2D.is_colliding():
		print("te pillé")
