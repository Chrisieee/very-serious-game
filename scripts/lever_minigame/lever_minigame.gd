extends Node2D

@onready var window = $Window
var correctSequence = [1, 2, 3]
var currentIndex = 0

@onready var timer = $Timer
@onready var timeLabel = $Window/timeLabel

func _ready():
	window.close_requested.connect(_on_close_requested)
	
	correctSequence.shuffle() #geeft een random volgorde
	print(correctSequence)
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	var levers = get_tree().get_nodes_in_group("levers")
	for lever in levers:
		lever.pulled.connect(_on_lever_pulled) #connect het signaal van de levers

func _process(delta: float):
	timeLabel.text = str(int(ceil(timer.time_left)))

func _on_close_requested(complete):
	await get_tree().create_timer(1).timeout
	MinigameManager.close_minigame(complete, preload("res://scenes/minigames/lever_minigame.tscn"))
	queue_free()

func _on_timer_timeout():
	get_tree().get_first_node_in_group("failPopup").visible = true
	await get_tree().create_timer(1).timeout
	
	_on_close_requested(false)

func _on_lever_pulled(leverId):
	var levers = get_tree().get_nodes_in_group("levers")
	
	if leverId == correctSequence[currentIndex]:
		currentIndex += 1
		for lever in levers:
			if lever.leverId == leverId:
				lever.change_color(true)
		
		if currentIndex >= correctSequence.size():
			timer.paused = true
			get_tree().get_first_node_in_group("winPopup").visible = true
			
			await get_tree().create_timer(1).timeout
			GameManager.fix_machine()
			_on_close_requested(true)

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
