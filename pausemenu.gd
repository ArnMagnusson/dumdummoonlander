extends Control
@onready var pausemenu: CanvasLayer = $pausemenu

@onready var rigid_body_3d: RigidBody3D = $RigidBody3D


var pause

func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		pausemenu.visible = true
		pause = true
		get_tree().paused = true
		

func _on_continuebutton_pressed() -> void:
	pausemenu.hide()
	pause = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func _on_restartbutton_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_backtostartbutton_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://introscene.tscn")

func _on_quitbutton_pressed() -> void:
	get_tree().quit()
