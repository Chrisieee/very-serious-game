extends Control

@onready var lifeIcons = [
	$Panel/HBoxContainer/life1,
	$Panel/HBoxContainer/life2,
	$Panel/HBoxContainer/life3
]

func update_lives(lives: int):
	for i in range(lifeIcons.size()):
		lifeIcons[i].visible = i < lives
