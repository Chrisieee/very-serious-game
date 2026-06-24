extends Node2D

@onready var window = $Window
var correctSequence = [1, 2, 3]
var currentIndex = 0

func _ready():
	window.close_requested.connect(_on_close_requested)
	
	correctSequence.shuffle()
	print(correctSequence)
	
	var levers = get_tree().get_nodes_in_group("levers")
	for lever in levers:
		lever.pulled.connect(_on_lever_pulled) #connect het signaal van de levers

func _on_close_requested():
	MinigameManager.close_minigame()
	queue_free()
	
func _on_lever_pulled(leverId):
	print(leverId)
	
	var levers = get_tree().get_nodes_in_group("levers")
	
	if leverId == correctSequence[currentIndex]:
		currentIndex += 1
		for lever in levers:
			if lever.leverId == leverId:
				lever.change_color(true)
		
		if currentIndex >= correctSequence.size():
			get_tree().get_first_node_in_group("winPopup").visible = true
			await get_tree().create_timer(1).timeout
			GameManager.fix_machine()
			_on_close_requested()

	else:
		for lever in levers:
			if lever.leverId == leverId:
				lever.change_color(false)
		_reset_levers()
		currentIndex = 0
	
func _reset_levers():
	var levers = get_tree().get_nodes_in_group("levers")
	for lever in levers:
		lever.reset()
		
	print("game gereset")
