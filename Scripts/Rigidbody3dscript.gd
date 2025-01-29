extends RigidBody3D
#Next step add camera controls

#Force=Speed.
#torque=rotation energi
#Thrusters speed.
@export var thrust = 10
#Postitivetorque W and A keys
@export var positivetorque = 1
@export var negativetorque = -1
# Called when the node enters the scene tree for the first time.

#Key input detected
var w_is_pressed = false
var a_is_pressed = false
var s_is_pressed = false
var d_is_pressed = false
var space_is_pressed = false
func _ready():
	pass
	
#input and force handling
func _process(delta):
	#reset state
	space_is_pressed = false
	w_is_pressed = false
	a_is_pressed = false
	s_is_pressed = false
	d_is_pressed = false
	#Up thrust
	if Input.is_action_pressed("ui_accept"):
		print("SPACE")
		space_is_pressed = true
	
	#Pitch thrust forward
	if Input.is_action_pressed("PitchS"):
		s_is_pressed = true
	#Pitch thrust backwards
	if Input.is_action_pressed("PitchW"):
		w_is_pressed = true
	#Yaw left
	if Input.is_action_pressed("YawA"):
		a_is_pressed = true
	
	#Yaw right
	if Input.is_action_pressed("YawD"):
		d_is_pressed = true
		
func _integrate_forces(state):
	var local_up = transform.basis.y #local y axis
	
	if space_is_pressed:
		apply_central_force(Vector3(local_up * thrust))
	if w_is_pressed:
		apply_torque(Vector3(negativetorque, 0, 0))
	if a_is_pressed:
		apply_torque(Vector3(0, 0, positivetorque))
	if s_is_pressed:
			apply_torque(Vector3(positivetorque, 0, 0))
	if d_is_pressed:
		apply_torque(Vector3(0, 0, negativetorque))
