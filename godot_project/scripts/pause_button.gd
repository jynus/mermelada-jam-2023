extends Button


func _ready():
	pass

func _on_pressed():
	$"../pauseMenu".pause_game()
