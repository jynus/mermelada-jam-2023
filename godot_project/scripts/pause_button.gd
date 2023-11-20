extends Button


func _ready():
	pass

func _on_pressed():
	# Presionar ESCAPE
	get_tree().paused = true
