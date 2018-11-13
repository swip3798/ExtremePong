extends Node2D

var speed
var posX
var posY
signal collision_detected
var points
var width
var height
var texture

var origHeight
var origSpeed
var origPosX
var origPosY

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
	origSpeed = speed
	origPosX = posX
	origPosY = posY

func move_up(delta):
	posY -= speed*delta
	validatePosition()
	set_position(Vector2(posX,posY))
	
func move_down(delta):
	posY += speed*delta
	validatePosition()
	set_position(Vector2(posX,posY))


func _on_Area2D_area_entered(area):
	emit_signal("collision_detected")

func inc_speed(inc):
	speed = clamp(speed+inc, 0.2 * origSpeed, 4 * origSpeed)
	print("Player logs: ", "increase speed on ", name, " to ", speed, " by ", inc, ". New Player speed is ", speed)

func dec_speed(dec):
	speed = clamp(speed-dec, 0.2 * origSpeed, 4 * origSpeed)
	print("Player logs: ", "decreased speed on ", name, " to ", speed, " by ", dec, ". New Player speed is ", speed)

func inc_size(percent):
	percent = float(percent)
	percent /= 100
	scale = get_scale()
	scale[1] = clamp(scale[1]+percent, 0.2, globalData.getOption("height")/origHeight)
	set_scale(scale)
	height = origHeight * get_scale()[1]
	print("Player logs: ", "increase size on ", name, " to ", height, " by ", percent, ". New Player scale is ", scale[1])
	
func dec_size(percent):
	percent = float(percent)
	percent /= 100
	scale = get_scale()
	scale[1] = clamp(scale[1]-percent, 0.2, globalData.getOption("height")/origHeight)
	set_scale(scale)
	height = origHeight * get_scale()[1]
	print("Player logs: ", "decreased size on ", name, " to ", height, " by ", percent, ". New Player scale is ", scale[1])
	
func validatePosition():
	var sh = globalData.getOption("height")
	if height >= sh:
		posY = sh/2
	elif posY + (height/2) > sh:
		posY = sh-(height/2)
	elif posY - (height/2) < 0:
		posY = height/2

func on_collision():
	print("Player logs: ", "Collision detected")
	
func reset():
	set_scale(Vector2(1,1))
	height = origHeight
	speed = origSpeed
	
	