extends Area2D

func _on_body_entered(body) -> void:
	if body.name == "player":
		body.current_interactable = self
		$label.visible = true
		print("enter")


func _on_body_exited(body) -> void:
	if body.name == "player":
		body.current_interactable = null
		$label.visible = false
		print("exit")

func interact():
	MinigameManager.start_random_minigame()
