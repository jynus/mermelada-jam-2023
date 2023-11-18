extends CharacterBody2D

var speed = randi_range(1, 2)

func _physics_process(delta):
	move_and_slide()

func initialize(_start_position, player_position):
	look_at(player_position)

func _on_visible_on_screen_enabler_2d_screen_entered():
	queue_free()
