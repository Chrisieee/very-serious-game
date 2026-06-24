extends Panel

func _ready():
	add_to_group("break_popup")

func show_popup():
	visible = true
	
func close_popup():
	visible = false
