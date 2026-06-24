extends Area2D

var isWorking = true
@export var machineId: int

func _ready():
	add_to_group("machines")

func _on_body_entered(body) -> void:
	if !isWorking:
		if body.name == "player":
			body.current_interactable = self
			$label.visible = true
			print("enter")

func _on_body_exited(body) -> void:
	if !isWorking:
		if body.name == "player":
			body.current_interactable = null
			$label.visible = false
			print("exit")

func change_working_state(work):
	if work:
		isWorking = true
		$light.set_color("#7CFC00")
		$label.visible = false
	elif !work:
		isWorking = false
		$light.set_color("#D2042D")
		$label.visible = false

func interact():
	MinigameManager.start_random_minigame()
