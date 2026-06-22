extends Node2D

@onready var window = $Window

func _ready():
	window.close_requested.connect(_on_close_requested)

func _on_close_requested():
	MinigameManager.close_minigame()
	queue_free()
