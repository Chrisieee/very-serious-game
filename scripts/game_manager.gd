extends Node

var startLives = 1
var machines
var hud
var brokenMachine
var levelActive = false
var lives

func initialize_level():
	lives = startLives
	levelActive = true
	await get_tree().process_frame
	machines = get_tree().get_nodes_in_group("machines")
	hud = get_tree().current_scene.get_node("CanvasLayer/hud")
	break_machine()
	hud.update_lives(lives)

func break_machine():
	if !levelActive: return
	
	var rng = RandomNumberGenerator.new()
	var number = rng.randi_range(1, machines.size())

	for machine in machines:	
		print(machine)
		if machine.machineId == number:
			machine.change_working_state(false)
			brokenMachine = number
			
	get_tree().get_first_node_in_group("break_popup").show_popup()

func fix_machine():
	for machine in machines:
		if machine.machineId == brokenMachine:
			machine.change_working_state(true)
			brokenMachine = null
	
	await get_tree().create_timer(5).timeout
	break_machine()

func lose_live():
	lives -= 1
	hud.update_lives(lives)
	
	if lives == 0:
		await get_tree().process_frame
		game_over()

func game_over():
	levelActive = false
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func complete_game():
	levelActive = false
	get_tree().change_scene_to_file("res://scenes/completed.tscn")
