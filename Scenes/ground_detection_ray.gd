extends RayCast3D
@onready var ground_detection = $"."
var parent_rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#get distance to ground from ground detection func.
	var distance = _ground_detection()
	if distance != null: #makes sure their is ground
		print("Distance to ground: ", distance) #prints how far to ground their is
	else:
		print("No ground detected!") #if no ground is detected.
		
	#rotation lock
	parent_rotation = get_parent().rotation
	set_rotation(- parent_rotation)

#ground detection script sends info to process
func _ground_detection():
	if ground_detection.is_colliding(): #if ground_detection run script.
		var ground_posisition = ground_detection.get_collision_point()#Get raycast3d collision point
		return global_transform.origin.distance_to(ground_posisition)#Sets distance to ground_posisiton
	return null#returns null if nothing is detected
