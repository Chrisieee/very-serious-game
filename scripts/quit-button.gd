extends Button

func _pressed():
	AudioManager.play_sound(preload("res://src/sounds/click.mp3"), -15)
	get_tree().change_scene_to_file("res://scenes/quit.tscn")
