extends Node3D

@onready var lander: RigidBody3D = $Lander
@onready var hud: Node2D = $HUD

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	update_hud()

func update_hud():
	hud.xvelocitylabel.text = str(round(lander.linear_velocity.x))
	hud.yvelocitylabel.text = str(round(lander.linear_velocity.y))
	hud.zvelocitylabel.text = str(round(lander.linear_velocity.z))
	hud.fuellabel.text = str(round(lander.fuel)) + "%"
	hud.thrustgearlabel.text = str(lander.thrust)
	hud.altitudelabel.text = str(round(lander.position.y))
	
	if Input.is_action_pressed("ui_accept"):
		hud.thrustcolorrect.color = Color(0.094, 0.613, 0)
	else:
		hud.thrustcolorrect.color = Color(0.944, 0, 0.17)
