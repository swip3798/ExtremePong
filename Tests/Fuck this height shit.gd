extends Node2D

var upper 
var downer 
var object
var area
var coll



func _ready():
	upper = get_node("Upper")
	downer = get_node("Downer")
	object = get_node("Object")
	area = get_node("Area2D")
	coll = get_node("Area2D/CollisionShape2D")
	var height = object.texture.get_height()
	var size =  object.get_texture().get_size() * object.get_scale()
	height = size[1]
	print(object.get_global_transform_with_canvas())
	downer.set_position(Vector2(object.get_position()[0], object.get_position()[1] + height/2))
	upper.set_position(Vector2(object.get_position()[0], object.get_position()[1] - height/2))
	print("Downer: ", downer.get_position())
	print("Upper: ", upper.get_position())
