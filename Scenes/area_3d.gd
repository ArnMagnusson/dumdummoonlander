extends Area3D

@onready var lander: RigidBody3D = $"../../Lander"

func _on_body_entered(body: RigidBody3D) -> void:
	if lander.fuel >= 50:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://endscreen.tscn")
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://losescreen.tscn")
