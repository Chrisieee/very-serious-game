extends Node2D

#Je moet de juiste draden aan elkaar koppelen (among us achtig)
#Miss eerst met klikken om het makkelijker te maken

var ids = [1, 2, 3]
var check = []
var correct = []

func _ready():
	await get_tree().process_frame
	_set_up()
	
	var wireEndsRight = get_tree().get_nodes_in_group("wire_end_right")
	for wireEnd in wireEndsRight:
		wireEnd.click.connect(_on_wire_click)
		
	var wireEndsLeft = get_tree().get_nodes_in_group("wire_end_left")
	for wireEnd in wireEndsLeft:
		wireEnd.click.connect(_on_wire_click)

func _on_close_requested():
	MinigameManager.close_minigame()
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
				wireEnd.wireId = 1
				wireEnd.get_node("Label").text = "X"
			2:
				wireEnd.get_node("ColorRect").set_color("#7CFC00")
				wireEnd.wireId = 2
				wireEnd.get_node("Label").text = "O"
			3:
				wireEnd.get_node("ColorRect").set_color("#0000FF")
				wireEnd.wireId = 3
				wireEnd.get_node("Label").text = "|"
		i += 1
	
func _on_wire_click(wireId):
	print(wireId)
	check.append(wireId)
	var number = check.size()
	
	#TODO: je kan nog dezelfde klikken
	if check.size() == 2:
		if check[0] == check[1]:
			correct.append(check[0])
			_connect_wires(check[0]) 
		else:
			print("fail")
		
		check.clear()

func _connect_wires(id):
	var start_pos
	var end_pos
	var wireEndsRight = get_tree().get_nodes_in_group("wire_end_right")
	for wireEnd in wireEndsRight:
		if wireEnd.wireId == id:
			start_pos = wireEnd.get_node("Marker2D").global_position
		
	var wireEndsLeft = get_tree().get_nodes_in_group("wire_end_left")
	for wireEnd in wireEndsLeft:
		if wireEnd.wireId == id:
			end_pos = wireEnd.get_node("Marker2D").global_position
	
	_create_wire(start_pos, end_pos, id)
	
	if correct.size() == ids.size():
		get_tree().get_first_node_in_group("winPopup").visible = true

		await get_tree().create_timer(1).timeout
		GameManager.fix_machine()
		_on_close_requested()

func _create_wire(start_pos: Vector2, end_pos: Vector2, id):
	var line = Line2D.new()
	
	line.width = 30
	match id:
			1:
				line.default_color = "#D2042D"
			2:
				line.default_color = "#7CFC00"
			3:
				line.default_color = "#0000FF"
	
	line.add_point(line.to_local(start_pos))
	line.add_point(line.to_local(end_pos))
	
	$Window.add_child(line)
	
