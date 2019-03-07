extends Node2D

var speed
var speedFactor
var posX
var posY
var spriteSize
var activePlayer
var size
var lastScore

var origSpeed
var origScale

var globalData

signal collide_with_something

func _ready():
	globalData = get_node("/root/GlobalData")
	speedFactor = 1.0
	spriteSize = get_node("Sprite").texture.get_size()[0]
	size = spriteSize * get_scale()[0] * get_node("Sprite").get_scale()[0]
	speed = Vector2(0,0)
	origSpeed = speed
	origScale = get_scale()
	set_position(Vector2(globalData.getOption("width")/2, globalData.getOption("height")/2))
	
	get_node("Timer").start()
	print("Initial Ball size: ", size)
	
	
func _physics_process(delta):
	move(delta)
	
func move(delta):
	var step = (speed*delta*speedFactor)
	step[0] = clamp(step[0], -35, 35)
	translate(step)
	var pos = get_position()
	if pos[1]-size/2 < 0:
		set_position(Vector2(pos[0], size/2))
		speed[1] = abs(speed[1])
	elif pos[1]+size/2 > globalData.getOption("height"):
		set_position(Vector2(pos[0], globalData.getOption("height") - size/2))
		speed[1] = -abs(speed[1])
	
	if pos[0] < 0:
		score("Player2")
	elif pos[0] > globalData.getOption("width"):
		score("Player")

func _on_Area2D_area_entered(area):
	var object = area.get_parent()
	if object.filename == "res://Objects/Player.tscn":
		invX()
		activePlayer = object
		var rel_enterpoint = (object.get_position() - get_position())[1] / 100
		speed[1] = abs(speed[0] * rel_enterpoint)
		if rel_enterpoint > 0:
			speed[1] = -speed[1]
	else:
		emit_signal("collide_with_something")

func invX():
	speed[0] = -speed[0]


func dec_speed(percent):
	var rel = float(percent) / 100
	speedFactor = clamp(speedFactor-rel, 0.5, 2.5)
	print("Ball logs: ", "decreased speed on ", name, " by ", rel, ". New ball Speedfactor is ", speedFactor)
	
func inc_speed(percent):
	var rel = float(percent) / 100
	speedFactor = clamp(speedFactor+rel, 0.5, 2.5)
	print("Ball logs: ", "increased speed on ", name, " by ", rel, ". New ball Speedfactor is ", speedFactor)
	
func inc_size(percent):
	var scale = get_scale()
	var rel = float(percent) / 100
	scale[0] = clamp(scale[0]+rel, 0.3, 4)
	scale[1] = scale[0]
	set_scale(scale)
	size = spriteSize * get_scale()[0] * get_node("Sprite").get_scale()[0]
	print("Ball logs: ", "increased scale of ball on ", name, " by ", rel , ". New ball Scale is ", scale)
	print("Ball logs: ", "New ball Size is ", size)
	
func dec_size(percent):
	var scale = get_scale() 
	var rel = float(percent) / 100
	scale[0] = clamp(scale[0]-rel, 0.3, 4)
	scale[1] = scale[0]
	set_scale(scale)
	size = spriteSize * get_scale()[0] * get_node("Sprite").get_scale()[0]
	print("Ball logs: ", "decreased scale of ball on ", name, " by ", rel , ". New ball Scale is ", scale)
	print("Ball logs: ", "New ball Size is ", size)
	
func score(player):
	get_node("/root/Level/"+player).points += 1
	get_node("/root/Level").reset()
	reset()
	
func reset():
	get_node("/root/Level/Player").reset()
	get_node("/root/Level/Player2").reset()
	speed = Vector2(0,0)
	set_scale(origScale)
	set_position(Vector2(globalData.getOption("width")/2, globalData.getOption("height")/2))
	get_node("Timer").start()

func _on_Timer_timeout():
	if lastScore == "Player":
		speed = Vector2(600, 0)
	else:
		speed = Vector2(-600,0)