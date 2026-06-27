extends Node

@onready var musicPlayer = AudioStreamPlayer.new()
@onready var ambientPlayer = AudioStreamPlayer.new()

func _ready():
	add_child(musicPlayer)
	add_child(ambientPlayer)

func play_music(stream: AudioStream):
	if musicPlayer.stream == stream:
		return

	musicPlayer.stream = stream
	musicPlayer.play()

func play_ambient():
	ambientPlayer.volume_db = -20
	ambientPlayer.stream = preload("res://src/sounds/casino.mp3")
	ambientPlayer.play()

func play_sound(stream: AudioStream, db: int):
	var player = AudioStreamPlayer.new()
	player.volume_db = db
	player.stream = stream
	add_child(player)
	player.play()

	player.finished.connect(func():
		player.queue_free()
	)
