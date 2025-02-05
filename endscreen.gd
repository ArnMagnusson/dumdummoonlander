extends Node2D


func _on_backtostartbuttonwin_pressed() -> void:
	get_tree().change_scene_to_file("res://introscene.tscn")


func _on_backtostartbuttonlose_pressed() -> void:
	get_tree().change_scene_to_file("res://introscene.tscn")
