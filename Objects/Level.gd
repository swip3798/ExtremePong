extends Node2D

var player1
var player2
var ball
var ptw

var globalData

func _ready():
	globalData = get_node("/root/GlobalData")
	ptw = globalData.getOption("ptw")
	get_node("PTW").text = "Points to win: " + str(ptw)
	player1 = get_node("Player")
	player2 = get_node("Player2")
	ball = get_node("Ball")
	get_node("KeyboardController1").set_player(player1)
	if globalData.getOption("ai_enabled"):
		get_node("AIController").set_player(player2)
		get_node("AIController").set_ball(ball)
		get_node("AIController").start_ai()
		get_node("KeyboardController2").set_player(player1)
	else:
		get_node("KeyboardController2").set_player(player2)
	update_labels()
	get_node("Ball").activePlayer = player2

func reset():
	var explosion = preload("res://Objects/Explosion.tscn").instance()
	explosion.set_position(ball.get_position())
	explosion.set_z_index(-1)
	add_child(explosion)
	update_labels()

func update_labels():
	get_node("PointsPlayer1").text = str(player1.points)
	get_node("PointsPlayer2").text = str(player2.points)
	if ptw <= player1.points:
		globalData.setOption("winner", "Player 1")
		get_tree().change_scene("res://Objects/Win Screen.tscn")
	elif ptw <= player2.points:
		globalData.setOption("winner", "Player 2")
		get_tree().change_scene("res://Objects/Win Screen.tscn")