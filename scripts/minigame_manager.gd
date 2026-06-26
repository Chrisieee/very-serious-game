extends Node

var minigames = [
	preload("res://scenes/minigames/lever_minigame.tscn"),
	preload("res://scenes/minigames/wire_minigame.tscn"),
	preload("res://scenes/minigames/plug_minigame.tscn"),
	#preload("res://scenes/minigames/gear_minigame.tscn"),
]
var availableMinigames = []
var first = true

func start_random_minigame():
	if availableMinigames.is_empty() && first: 
		first = false
		availableMinigames = minigames.duplicate()
		availableMinigames.shuffle()
	
	var container = get_tree().get_first_node_in_group("minigame_container")
	var player = get_tree().current_scene.get_node("player")
	
	var random_scene = availableMinigames[0]
	var game = random_scene.instantiate()
	
	container.add_child(game)
	player.ableToMove = false

func close_minigame(complete, scene):
	if complete: 
		availableMinigames.erase(scene)
	else:
		GameManager.lose_live()
	
	if availableMinigames.is_empty():
		GameManager.complete_game()
	else:
		var player = get_tree().current_scene.get_node("player")
		player.ableToMove = true

func reset_minigames():
	availableMinigames = []
	first = true
