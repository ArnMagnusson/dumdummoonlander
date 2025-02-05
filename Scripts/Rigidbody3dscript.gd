extends RigidBody3D
#Next step add camera controls
#camera movement
@onready var twist_pivot := $twistpivot
@onready var pitch_pivot := $twistpivot/pitchpivot
@export var twist_input := 0.0
@export var pitch_input := 0.0
#sensitivity on mouse
@export var mouse_sensitivity := 0.001

#Thrust=Speed.
#torque=rotation energi
#Thrusters speed.
@export var thrust = 10
#Postitivetorque W and A keys
@export var positivetorque = 1
@export var negativetorque = -1
# Called when the node enters the scene tree for the first time.

#Key input detection
var w_is_pressed = false
var a_is_pressed = false
var s_is_pressed = false
var d_is_pressed = false
var space_is_pressed = false
var esc_is_pressed = false

#fuel and speed
@export var fuel = 100
@export var speedmode1 = 900
@export var speedmode2 = 1200
@export var speedmode3 = 1500


func _ready():
#disable mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
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
		
	#escape with mouse
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

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
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-90),
		deg_to_rad(90)
		)
		
	twist_input = 0.0
	pitch_input = 0.0
	
#mouse inputs
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		twist_input = - event.relative.x * mouse_sensitivity
		pitch_input = - event.relative.y * mouse_sensitivity
