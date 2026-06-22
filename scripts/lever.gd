extends TextureButton

signal pulled(lever_id)

@export var leverId: int
@export var offTexture: Texture2D
@export var onTexture: Texture2D

var isOn = false

func _pressed():
	isOn = !isOn

	if isOn:
		texture_normal = onTexture
		pulled.emit(leverId)
	else:
		texture_normal = offTexture
