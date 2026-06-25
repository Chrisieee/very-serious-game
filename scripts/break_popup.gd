extends Panel

func _ready():
	add_to_group("break_popup")

func show_popup():
	visible = true
	#fade in animatie
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.3)
	
	await get_tree().create_timer(5).timeout
	close_popup()
	
func close_popup():
	#fade out animatie
	modulate.a = 1
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.3)
	
	await tween.finished #als de animatie voltooid is word hij onzichtbaar
	visible = false
