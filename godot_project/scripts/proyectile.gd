extends Area2D

@export var speed : float = 50
@onready var laser1 = %Laser1
@onready var laser2 = %Laser2

signal impacted

func _ready():
	laser1.self_modulate = Globals.COLOR_BAD
	laser2.self_modulate = Globals.COLOR_BAD

func _process(delta):
	position += speed * delta * Vector2(1, 0).rotated(rotation)

func _on_area_entered(area):
	impacted.emit()
	queue_free()

func set_collision(side: String):
	if side == "left":
		set_collision_mask_value(4, true)
	else:
		set_collision_mask_value(5, true)
