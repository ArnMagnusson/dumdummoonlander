extends RayCast3D
@onready var ground_detection = $"."
var parent_rotation

func _process(delta):
	#rotation lock
	parent_rotation = get_parent().rotation
	set_rotation(- parent_rotation)
	if is_colliding():
		crashed_oh_no()
	
	
func crashed_oh_no():
	get_tree().change_scene_to_file("res://losescreen.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
