extends Area2D

@export var speed : float = -200
@onready var sprite : Sprite2D = $Sprite

signal missed
signal touched

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	
	# despawn
	if position.x < -sprite.texture.get_width():
		missed.emit()
		queue_free()

func _on_area_entered(area):
	touched.emit()
	queue_free()
