extends Node

@onready var music_player : AudioStreamPlayer = %musicPlayer
var playlist : Dictionary = {
	"menu": preload("res://assets/music/whatx27s-in-the-biscuit-tin-154535.mp3"),
	"pause": preload("res://assets/music/Winter Reflections.mp3"),
	"game": preload("res://assets/music/Amazing Plan.mp3"),
	"cute": preload("res://assets/music/cute-baby-animals-playful-cute-woodwinds-174354.mp3"),
	"troll": preload("res://assets/music/Krampus Workshop.mp3"),
	"win": preload("res://assets/music/whatx27s-in-the-biscuit-tin-154535.mp3"),
	"lose": preload("res://assets/music/whatx27s-in-the-biscuit-tin-154535.mp3")}

var _current_song : String
@export var current_song : String :
	set (value):
		_set_current_song(value)
	get:
		return _current_song

func _set_current_song(value):
	_current_song = value
	music_player.stream = playlist[current_song]

func _ready():
	music_player.volume_db = -20

func _process(_delta):
	pass

func play_song(screen: String, offset : float = 0.0):
	if screen not in playlist.keys() or current_song == screen:
		return
	stop()
	current_song = screen
	music_player.play(offset)

func stop() -> float:
	var pos : float = music_player.get_playback_position()
	if music_player.playing:
		music_player.stop()
	return pos

