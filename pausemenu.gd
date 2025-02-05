extends Control
@onready var pausemenu: CanvasLayer = $pausemenu

var pause

func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		pausemenu.visible = true
		pause = true

func _on_continuebutton_pressed() -> void:
	pausemenu.hide()
	pause = false

func _on_restartbutton_pressed() -> void:
	get_tree().reload_current_scene()

func _on_backtostartbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://introscene.tscn")

func _on_quitbutton_pressed() -> void:
	get_tree().quit()
