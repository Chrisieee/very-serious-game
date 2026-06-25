extends Node2D

#TODO: Miss dragging toevoegen?

var ids = [1, 2, 3]
var check = []
var correct = []
var wires = []

@onready var timer = $Timer
@onready var timeLabel = $Window/timeLabel

func _ready():
	await get_tree().process_frame
	_set_up()
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	var wireEnds = get_tree().get_nodes_in_group("wire_ends")
	for wireEnd in wireEnds:
		wireEnd.click.connect(_on_wire_click)

func _process(delta: float):
	timeLabel.text = str(int(ceil(timer.time_left)))

func _on_timer_timeout():
	get_tree().get_first_node_in_group("failPopup").visible = true
	await get_tree().create_timer(1).timeout
	
	_on_close_requested(false)

func _on_close_requested(complete):
	MinigameManager.close_minigame(complete, preload("res://scenes/minigames/wire_minigame.tscn"))
	queue_free()

func _set_up():
	_set_up_wire("left")
	_set_up_wire("right")
		
func _set_up_wire(side):
	var wireEnds
	match side:
		"right":
			wireEnds = get_tree().get_nodes_in_group("wire_end_right")
		"left":
			wireEnds = get_tree().get_nodes_in_group("wire_end_left")
			
	var i = 0
	ids.shuffle()
	
	for wireEnd in wireEnds:
		match ids[i]:
			1:
				wireEnd.get_node("ColorRect").set_color("#D2042D")
				wireEnd.colorId = 1
				wireEnd.get_node("Label").text = "X"
			2:
				wireEnd.get_node("ColorRect").set_color("#7CFC00")
				wireEnd.colorId = 2
				wireEnd.get_node("Label").text = "O"
			3:
				wireEnd.get_node("ColorRect").set_color("#0000FF")
				wireEnd.colorId = 3
				wireEnd.get_node("Label").text = "|"
			
		print(wireEnd.colorId)
		i += 1
	
func _on_wire_click(wireId, colorId):
	var wireEnds = get_tree().get_nodes_in_group("wire_ends")
	for wireEnd in wireEnds:
		if wireEnd.wireId == wireId:
			wireEnd.get_node("Border").visible = true
	
	if wires.size() == 0:
		wires.append(wireId)
		check.append(colorId)
	elif wires.size() < 2 && wireId != wires[0]:
		wires.append(wireId)
		check.append(colorId)
	else:
		return

	if check.size() == 2:
		if check[0] == check[1]:
			correct.append(check[0])
			_connect_wires(wires, check[0]) 
		else:
			print("fail")
		wires.clear()
		check.clear()

		for wireEnd in wireEnds:
			wireEnd.get_node("Border").visible = false

func _connect_wires(wireIds, colorId):
	var pos = []
	var wireEnds = get_tree().get_nodes_in_group("wire_ends")
	for wireEnd in wireEnds:
		if wireEnd.wireId == wireIds[0] || wireEnd.wireId == wireIds[1]:
			pos.append(wireEnd.get_node("Marker2D").global_position)
	
	_create_wire(pos, colorId)
	
	if correct.size() == ids.size():
		get_tree().get_first_node_in_group("winPopup").visible = true

		await get_tree().create_timer(1).timeout
		GameManager.fix_machine()
		_on_close_requested(true)

func _create_wire(pos, id):
	var line = Line2D.new()
	
	line.width = 30
	match id:
			1:
				line.default_color = "#D2042D"
			2:
				line.default_color = "#7CFC00"
			3:
				line.default_color = "#0000FF"
	
	line.add_point(line.to_local(pos[0]))
	line.add_point(line.to_local(pos[1]))
	
	$Window.add_child(line)
	
