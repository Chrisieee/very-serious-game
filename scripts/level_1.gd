extends Node2D

func _ready():
	await get_tree().process_frame #hij wacht 1 frame zodat alles laad
	GameManager.initialize_level()
