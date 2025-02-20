extends Area3D
@onready var lander: RigidBody3D = $"../../Lander"
var landed := false

func _process(delta):
	debug()
@warning_ignore("unused_parameter")
func _on_body_entered(body: RigidBody3D) -> void:
	if lander.fuel >= 50 and landed == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://endscreen.tscn")
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://losescreen.tscn")


func _on_lander_landed():
	landed = true

func debug():
	if Input.is_action_just_pressed("debugkey"):
		print(landed)
