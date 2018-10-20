extends Node2D

var speed
var speedFactor
var posX
var posY
var coll
var activePlayer
var preserveSpeed
var height
var size
signal collide_with_something

func _ready():
	speed = Vector2(-600, -200)
	speedFactor = 1.0
	coll = get_node("Area2D/CollisionShape2D")
	size =  get_node("Sprite").get_texture().get_size() * get_scale()
	
func _process(delta):	
	move(delta)
	#print(speedFactor)
	
	
func move(delta):
	var step = (speed*delta*speedFactor)
	if abs(step[0]) > 35:
		step = Vector2(35 * (step[0] / abs(step[0])), step[1])
	print(position)
	set_position(get_position() + step)
	if get_position()[1] < 0:
		set_position(Vector2(get_position()[0], get_position()[1] * 0))
	if get_position()[1] > ProjectSettings.get_setting("globals/height"):
		set_position(Vector2(get_position()[0], ProjectSettings.get_setting("globals/height")))
	

func _on_Area2D_area_entered(area):
	var object = area.get_parent()
	if object.filename == "res://Objects/Player.tscn":
		invX()
		activePlayer = object
		var rel_enterpoint = (object.get_position() - get_position())[1] / 100
		if rel_enterpoint < 0:
			speed[1] = abs(speed[0] * rel_enterpoint)
		elif rel_enterpoint > 0:
			speed[1] = abs(speed[0] * rel_enterpoint)
			speed[1] = -speed[1]
	elif area.filename == "res://Objects/Border.tscn":
		invY()
		emit_signal("collide_with_something")
	else:
		emit_signal("collide_with_something")

func invX():
	speed[0] = -speed[0]
func invY():
	speed[1] = -speed[1]
	
func limitSpeed():
	if abs(speedFactor) < 0.5:
		if speedFactor < 0:
			speedFactor = -0.5
		else:
			speedFactor = 0.5
	elif abs(speedFactor) > 2.5 + scale[0] * 0.5:
		if speedFactor < 0:
			speedFactor = -2.5 + scale[0] * 0.5
		else:
			speedFactor = 2.5 + scale[0] * 0.5
	
func dec_speed(percent):
	var rel = float(percent) / 100
	speedFactor -= rel
	limitSpeed()
	print("decreased speed on ", name, " on ", speedFactor, " with ", rel, "%")
	
func inc_speed(percent):
	limitSpeed()
	var rel = float(percent) / 100
	speedFactor += rel
	print("increased speed on ", name, " on ", speedFactor, " with ", percent, "%")
	
func inc_size(percent):
	print("increased scale on ", name)
	var scle = get_scale() * (1 + float(percent) / 100)
	if scle[1] > 6:
		scle= Vector2(6, 6)
	set_scale(scle)
	size =  get_node("Sprite").get_texture().get_size() * get_scale()
	
func dec_size(percent):
	print("decreased scale on ", name)
	var scle = get_scale() * (1 - float(percent) / 100)
	if scle[1] < 0.3:
		scle= Vector2(0.3, 0.3)
	set_scale(scle)
	size =  get_node("Sprite").get_texture().get_size() * get_scale()
	
func reset():
	preserveSpeed  = Vector2(speed[0], 0)
	speed = Vector2(0,0)
	get_node("Timer").start()
	set_position(Vector2(ProjectSettings.get_setting("globals/width")/2, ProjectSettings.get_setting("globals/height")/2))

func _on_Timer_timeout():
	speed = preserveSpeed
