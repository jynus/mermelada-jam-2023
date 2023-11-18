extends Area2D

@export var speed : float = 50

signal impacted

func _ready():
	pass # Replace with function body.

func _process(delta):
	position += speed * delta * Vector2(1, 0).rotated(rotation)


func _on_area_entered(area):
	impacted.emit()
	queue_free()
