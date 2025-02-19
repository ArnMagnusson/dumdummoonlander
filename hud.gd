extends Node2D

@onready var xvelocitylabel: Label = $velocityxdisplay/xvelocitylabel
@onready var rigid_body_3d: RigidBody3D = $"../RigidBody3D"



xvelocitylabel.text = get_linear_velocity.x(rigid_body_3d)
