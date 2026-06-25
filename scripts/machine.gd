extends Area2D

var isWorking = true
@export var machineId: int

func _ready():
	add_to_group("machines")

func _process(delta: float):
	if isWorking:
		$AnimationPlayer.play("on")
	else:
		$AnimationPlayer.stop()

func _on_body_entered(body) -> void:
	if !isWorking:
		if body.name == "player":
			body.current_interactable = self
			$label.visible = true

func _on_body_exited(body) -> void:
	if !isWorking:
		if body.name == "player":
			body.current_interactable = null
			$label.visible = false

func change_working_state(work):
	if work:
		isWorking = true
		$light.set_color("#7CFC00")
		$label.visible = false
		$light/Label.text = "|"
	elif !work:
		isWorking = false
		$light.set_color("#D2042D")
		$label.visible = false
		$light/Label.text = "O"

func interact():
	MinigameManager.start_random_minigame()
