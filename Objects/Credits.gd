extends Control

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_pause"):
		_on_Back_button_up()

func _on_Back_button_up():
	get_tree().change_scene("res://Objects/Main Menu.tscn")
