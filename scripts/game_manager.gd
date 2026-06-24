extends Node

var machines
var brokenMachine

func _ready():
	machines = get_tree().get_nodes_in_group("machines")
	await get_tree().process_frame
	break_machine()

func break_machine():
	var rng = RandomNumberGenerator.new()
	var number = rng.randi_range(1, 3)

	for machine in machines:
		if machine.machineId == number:
			machine.change_working_state(false)
			brokenMachine = number
			
	get_tree().get_first_node_in_group("break_popup").show_popup()

func fix_machine():
	for machine in machines:
		if machine.machineId == brokenMachine:
			machine.change_working_state(true)
			brokenMachine = null
	
	get_tree().get_first_node_in_group("break_popup").close_popup()
	
	await get_tree().create_timer(5).timeout
	break_machine()
