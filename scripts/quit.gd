extends Node2D

func _ready():
	AudioManager.play_sound(preload("res://src/sounds/easteregg.mp3"), -15)
