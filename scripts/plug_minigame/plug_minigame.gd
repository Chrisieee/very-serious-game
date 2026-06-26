extends Node2D
#Je moet de stekker er uit halen en er terug in doen

@onready var window = $Window
@onready var timer = $Timer
@onready var timeLabel = $Window/timeLabel
var done = false

func _ready():
	window.close_requested.connect(_on_close_requested)
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	var plug = window.get_node("plug")
	plug.on.connect(_on_plug_connect)
	
func _process(delta: float):
	timeLabel.text = str(int(ceil(timer.time_left)))

func _on_close_requested(complete):
	await get_tree().create_timer(1).timeout
	MinigameManager.close_minigame(complete, preload("res://scenes/minigames/plug_minigame.tscn"))
	queue_free()

func _on_timer_timeout():
	get_tree().get_first_node_in_group("failPopup").visible = true
	await get_tree().create_timer(1).timeout
	
	_on_close_requested(false)

func _on_plug_connect():
	var plug = window.get_node("plug")
	if plug.isOn:
		timer.paused = true
		get_tree().get_first_node_in_group("winPopup").visible = true
		
		await get_tree().create_timer(1).timeout
		GameManager.fix_machine()
		_on_close_requested(true)
