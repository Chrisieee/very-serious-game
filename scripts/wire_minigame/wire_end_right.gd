extends TextureButton

@export var wireId: int
var colorId
signal click(wireId, colorId)

func _ready():
	add_to_group("wire_end_right")
	add_to_group("wire_ends")

func _pressed():
	click.emit(wireId, colorId)
