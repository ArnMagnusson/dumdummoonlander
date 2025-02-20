extends Node2D

var linear_velocity

@onready var xvelocitylabel: Label = $velocityxdisplay/xvelocitylabel
@onready var yvelocitylabel: Label = $velocityydisplay/yvelocitylabel
@onready var zvelocitylabel: Label = $velocityzdisplay/zvelocitylabel
@onready var fuellabel: Label = $fueldisplay/fuellabel
@onready var thrustgearlabel: Label = $throttlegeardisplay/thrustgearlabel
@onready var altitudelabel: Label = $altitudedisplay/altitudelabel
@onready var thrustcolorrect: ColorRect = $throttledisplay/thrustcolorrect
