extends RigidBody3D
#camera movement
@onready var twist_pivot := $twistpivot
@onready var pitch_pivot := $twistpivot/pitchpivot
@export var twist_input := 0.0
@export var pitch_input := 0.0
#leg
@onready var leg = $leg
signal landed
#sensitivity on mouse
@export var mouse_sensitivity := 0.001
#Thrust=Speed.
#torque=rotation energi
#Thrusters speed.
@export var thrust = 10
#Postitivetorque W and A keys
@export var positivetorque = 0.5
@export var negativetorque = -0.5
# Called when the node enters the scene tree for the first time.

#Key input detection
var w_is_pressed = false
var a_is_pressed = false
var s_is_pressed = false
var d_is_pressed = false
var space_is_pressed = false
var esc_is_pressed = false
var e_is_pressed = false
var q_is_pressed = false

#fuel and speed
@export var fuel = 100
@export var fuel_consuption = 5
@export var initial_velocity: Vector3 = Vector3(-30, -20, -40)
var has_crashed = false

func _ready():
#disable mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#linear_velocity = initial_velocity #only enable this for funny test
	
#input and force handling
func _process(delta):
	update_camera(delta) #calls camera function
	FUEL_TANK(delta) #calls fuel
		
	if leg.is_colliding():
		print("leg colliding")
		emit_signal("landed")
		
	#reset state
	space_is_pressed = false
	w_is_pressed = false
	a_is_pressed = false
	s_is_pressed = false
	d_is_pressed = false
	q_is_pressed = false
	e_is_pressed = false
	#Up thrust
	if Input.is_action_pressed("ui_accept"):
		#print("SPACE")
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
	if Input.is_action_pressed("RotationLEFT"):
		q_is_pressed = true
	if Input.is_action_pressed("rotationRight"):
		e_is_pressed = true
	#escape with mouse
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#fuel part
	if fuel > 0:
		if Input.is_action_just_pressed("speed1"):
			thrust=10
			fuel_consuption=5
		if Input.is_action_just_pressed("speed2"):
			thrust=50
			fuel_consuption=10
		if Input.is_action_just_pressed("speed3"):
			thrust=70
			fuel_consuption=15
		if Input.is_action_just_pressed("debugkey"): #H
			print(thrust)
			print(fuel)
	
@warning_ignore("unused_parameter")
func _integrate_forces(state):
	var local_up = transform.basis.y #local y axis space, Q and E
	var local_side = transform.basis.x #local x axis, W and S
	var local_rotate = transform.basis.z #local z axis D and A
	if space_is_pressed:
		apply_central_force(Vector3(local_up * thrust))
		#print("Yes")
	if w_is_pressed:
		apply_torque(Vector3(local_side*negativetorque))
	if a_is_pressed:
		apply_torque(Vector3(local_rotate*positivetorque))
	if s_is_pressed:
			apply_torque(Vector3(local_side*positivetorque))
	if d_is_pressed:
		apply_torque(Vector3(local_rotate*negativetorque))
	if e_is_pressed:
		apply_torque(Vector3(local_up*positivetorque))
	if q_is_pressed:
		apply_torque(Vector3(local_up*negativetorque))
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func FUEL_TANK(delta):
	if Input.is_action_pressed("ui_accept") and fuel > 0:
		fuel -= fuel_consuption * delta
	if fuel <=0:
		thrust = 0

func explode():
	pass
		
#mouse inputs
func _input(event):
	if event is InputEventMouseMotion:
		twist_input = - event.relative.x * mouse_sensitivity
		#print("hej")
		pitch_input = - event.relative.y * mouse_sensitivity
		
func update_camera(delta):
	# Smooth out rotation inputs over time
	twist_input = lerp(twist_input, 0.0, 5 * delta)
	pitch_input = lerp(pitch_input, 0.0, 5 * delta)

	# Apply rotation
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)

	# Clamp pitch rotation to prevent flipping
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-90),
		deg_to_rad(90)
		)
