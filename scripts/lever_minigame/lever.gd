extends TextureButton

signal pulled(leverId)
signal unPulled(leverId)

@export var leverId: int
@export var offTexture: Texture2D
@export var onTexture: Texture2D

var isOn = false
var light

func _ready():
	add_to_group("levers")
	light = get_node("light")

func _pressed():
	isOn = !isOn
	AudioManager.play_sound(preload("res://src/sounds/lever.mp3"), -20)
	if isOn:
		texture_normal = onTexture
		pulled.emit(leverId)
	else:
		texture_normal = offTexture
		unPulled.emit(leverId)
		
func reset():
	await get_tree().create_timer(0.5).timeout
	
	texture_normal = offTexture
	isOn = false
	light.set_color("#fffffe")
	
func change_color(good):
	if good:
		light.set_color("#7CFC00")
	else:
		light.set_color("#D2042D")
