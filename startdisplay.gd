extends CanvasLayer

func _on_startbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/the moon.tscn")

func _on_infobutton_pressed() -> void:
	get_tree().change_scene_to_file("res://infoscreen.tscn")


func _on_quitbutton_pressed() -> void:
	get_tree().quit()
