extends Node2D

var state
var background
var symbol
var scaleIdx
var powerFactor

func _ready():
	if ProjectSettings.has_setting("globals/powerfactor"):
		powerFactor =  ProjectSettings.get_setting("globals/powerfactor")
	else:
		powerFactor = 5.0
	background = get_node("background")
	symbol = get_node("Symbol")
	randomize()
	state = randi() % 8
#	state = 4
	if state >=0 and state <=3:
		background.set_modulate(Color("00ffed"))
		if state == 0:
			symbol.set_rotation_degrees(-90)
		elif state == 1:
			symbol.set_rotation_degrees(90)
		elif state == 2:
			symbol.set_texture(load("res://assets/get up.png"))
		elif state == 3:
			symbol.set_texture(load("res://assets/get down.png"))
	else:
		background.set_modulate(Color("ff0000"))
		if state == 4:
			symbol.set_rotation_degrees(-90)
		elif state == 5:
			symbol.set_rotation_degrees(90)
		elif state == 6:
			symbol.set_texture(load("res://assets/get up.png"))
		elif state == 7:
			symbol.set_texture(load("res://assets/get down.png"))



func _on_activated(area):
	print("Area: ", area.name)
	print("Area.filename: ", area.get_parent().filename)
	if area.filename != "res://Objects/Border.tscn" and area.get_parent().name.find("PowerUP", 0) == -1:
		var object = area.get_parent()
		print("Object: ", object.name)
		if state >=0 and state <=3:
			var aply = object.activePlayer
			print(aply.name)
			if state == 0:
				aply.inc_speed((randi() % 100 + 50)*powerFactor)
			elif state == 1:
				aply.dec_speed((randi() % 100 + 50)*powerFactor)
			elif state == 2:
				aply.inc_size((randi() % 30 + 10)*powerFactor)
			elif state == 3:
				aply.dec_size((randi() % 30 + 10)*powerFactor)
		else:
			print("Ball mode")
			var aply = object
			if state == 4:
				aply.inc_speed((randi() % 30 + 10)*powerFactor)
			elif state == 5:
				aply.dec_speed((randi() % 30 + 10)*powerFactor)
			elif state == 6:
				aply.inc_size((randi() % 30 + 10)*powerFactor)
			elif state == 7:
				aply.dec_size((randi() % 30 + 10)*powerFactor)
		queue_free()















