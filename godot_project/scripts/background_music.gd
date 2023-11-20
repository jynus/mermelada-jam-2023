extends Node

@onready var music_player : AudioStreamPlayer = %musicPlayer
var playlist : Dictionary = {
	"menu": preload("res://assets/music/loop menu.ogg"),
	"pause": preload("res://assets/music/loop menu.ogg"),
	"cute": preload("res://assets/music/loop cuqui.ogg"),
	"troll": preload("res://assets/music/loop troll.ogg"),
	"creepy": preload("res://assets/music/loop creepy.ogg"),
	"win": preload("res://assets/music/loop menu.ogg"),
	"lose": preload("res://assets/music/loop transicion.ogg")}

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
	music_player.volume_db = -5

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

