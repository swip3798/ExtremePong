extends Node

var Player

func _ready():
	set_process(false)
	
func set_player(player):
	Player = player
	set_process(true)
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		Player.move_up(delta)
	elif Input.is_action_pressed("ui_down"):
		Player.move_down(delta)
	elif Input.is_action_pressed("ui_pause"):
		var menu = preload("res://Objects/PauseMenu.tscn").instance()
		menu.set_position(Vector2(0,0))
		add_child(menu)
		get_tree().paused = true


