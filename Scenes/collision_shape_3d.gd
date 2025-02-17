extends CollisionShape3D



func _on_child_entered_tree(node: Node) -> void:
	get_tree().change_scene_to_file("res://endscreen.tscn")
