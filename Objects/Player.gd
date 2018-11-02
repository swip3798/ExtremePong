extends Node2D

var speed
var posX
var posY
signal collision_detected
var points
var width
var height
var origHeight
var texture

var globalData

func _ready():

	globalData = get_node("/root/GlobalData")

	posX = get_position()[0]
	posY = get_position()[1]
	speed = 500
	points = 0
	texture = get_node("Sprite").texture
	width = texture.get_size()[0]
	height = texture.get_size()[1]
	origHeight = height

func move_up(delta):
	posY -= speed*delta
	if (posY - (height/2)) < 0:
		if height < globalData.getOption("height"):
			posY = height/2
		else:
			posY = globalData.getOption("height") / 2
	set_position(Vector2(posX,posY))
	
func move_down(delta):
	posY += speed*delta
	if (posY+(height/2)) > globalData.getOption("height"):
		if height < globalData.getOption("height"):
			posY = globalData.getOption("height")-(height/2)
		else:
			posY = globalData.getOption("height") / 2
	set_position(Vector2(posX,posY))


func _on_Area2D_area_entered(area):
	emit_signal("collision_detected")

func inc_speed(inc):
	speed += inc
	print("Player logs: ", "increase speed on ", name, " to ", speed, " with ", inc)

func dec_speed(dec):
	speed -= dec
	print("Player logs: ", "decreased speed on ", name, " to ", speed, " with ", dec)

func inc_size(percent):
	percent = float(percent)
	percent /= 100
	scale = get_scale()
	scale[1] += percent
	set_scale(scale)
	height = origHeight * get_scale()[1]
	print("Player logs: ", "increase size on ", name, " to ", height, " by ", percent, ". New Player scale is ", scale[1])
	
func dec_size(percent):
	percent = float(percent)
	percent /= 100
	scale = get_scale()
	scale[1] -= percent
	if scale[1] < 0.2:
		scale[1] = 0.2
	set_scale(scale)
	height = origHeight * get_scale()[1]
	print("Player logs: ", "decreased size on ", name, " to ", height, " by ", percent, ". New Player scale is ", scale[1])
	
func on_collision():
	print("Player logs: ", "Collision detected")