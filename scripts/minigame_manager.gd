extends Node

var minigames = [
	preload("res://scenes/minigames/lever_minigame.tscn"),
	#preload("res://scenes/minigames/gear_minigame.tscn"),
	preload("res://scenes/minigames/wire_minigame.tscn"),
	#preload("res://scenes/minigames/plug_minigame.tscn"),
]
var current = 0

func _ready():
	minigames.shuffle()

func start_random_minigame():
	if minigames.is_empty(): return
	
	var container = get_tree().get_first_node_in_group("minigame_container")
	var player = get_tree().current_scene.get_node("player")
	
	var random_scene = minigames[current]
	var game = random_scene.instantiate()
	
	container.add_child(game)
	current += 1
	if current > minigames.size() - 1: current = 0
	player.ableToMove = false

func close_minigame():
	var player = get_tree().current_scene.get_node("player")
	player.ableToMove = true
