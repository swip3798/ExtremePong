extends Node2D

var speed
var posX
var posY
signal collision_detected
var points
var width

func _ready():
	posX = get_position()[0]
	posY = get_position()[1]
	speed=500
	points = 0
	width = get_node("Sprite").texture.get_size()[0]

func move_up(delta):
	posY -= speed*delta
	if posY < 0:
		posY = 0
	set_position(Vector2(posX,posY))
	
func move_down(delta):
	posY += speed*delta
	if posY > ProjectSettings.get_setting("globals/height"):
		posY = ProjectSettings.get_setting("globals/height")
	set_position(Vector2(posX,posY))
	
func limit_speed():
	if abs(speed) < 100:
		if speed < 0:
			speed = 100
		else:
			speed = -100


func _on_Area2D_area_entered(area):
	emit_signal("collision_detected")

func inc_speed(inc):
	speed += inc
	print("Player logs: ", "increase speed on ", name, " on ", speed, " with ", inc)

func dec_speed(dec):
	speed -= dec
	print("Player logs: ", "decreased speed on ", name, " on ", speed, " with ", dec)

func inc_size(percent):
	percent = float(percent)
	percent /= 100
	scale = get_scale()
	scale[1] += percent
	set_scale(scale)
	
func dec_size(percent):
	percent = float(percent)
	percent /= 100
	scale = get_scale()
	scale[1] -= percent
	if scale[1] < 0.2:
		scale[1] = 0.2
	set_scale(scale)
	
func on_collision():
	print("Player logs: ", "Collision detected")