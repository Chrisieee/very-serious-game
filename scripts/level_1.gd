extends Node2D

func _ready():
	MinigameManager.reset_minigames()
	await get_tree().process_frame #hij wacht 1 frame zodat alles laad
	GameManager.initialize_level()
