extends Control

@onready var lifeIcons = [
	$HBoxContainer/life1,
	$HBoxContainer/life2,
	$HBoxContainer/life3
]

func update_lives(lives: int):
	for i in range(lifeIcons.size()):
		lifeIcons[i].visible = i < lives
