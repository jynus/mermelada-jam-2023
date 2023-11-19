extends Area2D

class_name Colirio

@export var speed : float = 200
@onready var sprite : Sprite2D = %Sprite
@onready var despawn_line : float

@onready var color = Globals.COLOR_GOOD

signal missed
signal touched

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.self_modulate = color
	update_despawn_area()
	get_tree().root.size_changed.connect(update_despawn_area)
	
func update_despawn_area():
	despawn_line = get_viewport().get_visible_rect().size.y + sprite.texture.get_height()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# fall
	position.y += speed * delta

	# despawn
	if position.y > despawn_line:
		missed.emit()
		queue_free()

func _on_area_entered(area):
	touched.emit()
	queue_free()
