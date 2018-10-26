extends Node

var Player

func _ready():
	set_process(false)
	
func set_player(player):
	Player = player
	set_process(true)
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_up_sec"):
		Player.move_up(delta)
	elif Input.is_action_pressed("ui_down_sec"):
		Player.move_down(delta)


