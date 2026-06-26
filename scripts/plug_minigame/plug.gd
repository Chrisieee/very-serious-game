extends TextureButton

signal on(leverId)

@export var offTexture: Texture2D
@export var onTexture: Texture2D

var isOn = true

func _pressed():
	isOn = !isOn

	if isOn:
		AudioManager.play_sound(preload("res://src/sounds/plug-in.mp3"), -15)
		texture_normal = onTexture
		on.emit()
	else:
		AudioManager.play_sound(preload("res://src/sounds/plug-out.mp3"), -15)
		texture_normal = offTexture
	
