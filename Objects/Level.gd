extends Node2D

var player1
var player2
var ball
var ptw

func _ready():
	ptw = 5
	if ProjectSettings.has_setting("globals/ptw"):
		ptw = ProjectSettings.get_setting("globals/ptw")
	get_node("PTW").text = "Points to win: " + str(ptw)
	player1 = get_node("Player")
	player2 = get_node("Player2")
	ball = get_node("Ball")
	get_node("KeyboardController1").set_player(player1)
	if ProjectSettings.get_setting("globals/ai_enabled"):
		get_node("AIController").set_player(player2)
		get_node("AIController").set_ball(ball)
		get_node("AIController").start_ai()
	else:
		get_node("KeyboardController2").set_player(player2)
	update_labels()
	ball.reset()
	get_node("Ball").activePlayer = player2

func reset():
	var explosion = preload("res://Objects/Explosion.tscn").instance()
	explosion.set_position(ball.get_position())
	explosion.set_z_index(-1)
	add_child(explosion)
	update_labels()
	ball.reset()

func _on_exit_left(area):
	ball.set_position(Vector2(0, ball.get_position()[1]))
	player2.points += 1
	reset()


func _on_exit_right(area):
	ball.set_position(Vector2(1280, ball.get_position()[1]))
	player1.points += 1
	reset()

func update_labels():
	get_node("PointsPlayer1").text = str(player1.points)
	get_node("PointsPlayer2").text = str(player2.points)
	if ptw <= player1.points:
		ProjectSettings.set_setting("globals/winner", "Player 1")
		get_tree().change_scene("res://Objects/Win Screen.tscn")
	elif ptw <= player2.points:
		ProjectSettings.set_setting("globals/winner", "Player 2")
		get_tree().change_scene("res://Objects/Win Screen.tscn")