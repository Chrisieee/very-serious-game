extends TextureButton

var wireId
signal click(wireId)

func _ready():
	add_to_group("wire_end_left")

func _pressed():
	click.emit(wireId)
