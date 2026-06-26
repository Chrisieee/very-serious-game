extends Node2D

@export var slotId: int

@onready var sprite = $AnimatedSprite2D

func _ready():
	add_to_group("slots")
	sprite.play("on")

func break_machine():
	sprite.play("broken")

func fixed():
	sprite.play("on")
