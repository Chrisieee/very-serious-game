extends Node

var startLives = 3
var machines = [1, 2, 3, 4]
var hud
var brokenMachine
var levelActive = false
var lives
var timer
var availableMachines = []
var gears
var slots

func initialize_level():
	lives = startLives
	levelActive = true
	await get_tree().process_frame
	gears = get_tree().get_nodes_in_group("machines")
	slots = get_tree().get_nodes_in_group("slots")
	hud = get_tree().current_scene.get_node("CanvasLayer/hud")
	break_machine()
	hud.update_lives(lives)
	availableMachines = []
	AudioManager.play_ambient()
	
	#add timer
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func break_machine():
	if !levelActive: return
	
	AudioManager.play_sound(preload("res://src/sounds/error.mp3"), -10)
	
	if availableMachines.is_empty():
		availableMachines = machines.duplicate()

	var number = availableMachines.pick_random()
	
	for machine in gears:	
		if machine.machineId == number:
			machine.change_working_state(false)
			brokenMachine = number
	
	for slot in slots:
		if slot.slotId == number:
			slot.break_machine()
			
	get_tree().get_first_node_in_group("break_popup").show_popup()

func fix_machine():
	AudioManager.play_sound(preload("res://src/sounds/complete.mp3"), -15)
	for machine in gears:
		if machine.machineId == brokenMachine:
			machine.change_working_state(true)
			
			for slot in slots:
				if slot.slotId == brokenMachine:
					slot.fixed()
			
			brokenMachine = null
			availableMachines.erase(machine.machineId)
	
	timer.start(5)

func _on_timer_timeout():
	if levelActive:
		break_machine()

func lose_live():
	AudioManager.play_sound(preload("res://src/sounds/damage.mp3"), -20)
	lives -= 1
	hud.update_lives(lives)
	
	if lives == 0:
		await get_tree().process_frame
		await get_tree().create_timer(1).timeout
		game_over()

func game_over():
	AudioManager.play_sound(preload("res://src/sounds/gameover.mp3"), -15)
	AudioManager.ambientPlayer.queue_free()
	timer.stop()
	levelActive = false
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func complete_game():
	AudioManager.play_sound(preload("res://src/sounds/complete-level.mp3"), -20)
	AudioManager.ambientPlayer.queue_free()
	timer.stop()
	levelActive = false
	get_tree().change_scene_to_file("res://scenes/completed.tscn")
