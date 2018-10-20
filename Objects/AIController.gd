extends Node

var Player
var Ball
var difficulty
var dtarget
var calculated
var go_to_point

func _ready():
	calculated = false
	if ProjectSettings.has_setting("globals/ai_difficulty"):
		difficulty = ProjectSettings.get_setting("globals/ai_difficulty")
	else:
		difficulty = 1
		ProjectSettings.set_setting("globals/ai_difficulty", 1)
		ProjectSettings.save()
	set_process(false)
	dtarget = get_parent().get_node("Debug Target")
	go_to_point = Vector2(0, ProjectSettings.get_setting("globals/height") / 2)
	
func set_player(player):
	Player = player

func set_ball(ball):
	Ball = ball
	
func start_ai():
	set_process(true)
	
func stop_ai():
	set_process(false)

func get_ball_y(BP, vB, bSize):
	var P_x = Player.get_position()[0]
	var vBx = vB[0]
	var vBy = vB[1]
	var B_x = BP[0]
	var B_y = BP[1]
	var height = bSize[1]
	var newB_y = (abs(P_x - B_x)/vBx) * vBy + B_y
	if newB_y < 0:
		var newPoint_x = ((0 - B_y)/vBy) * vBx + B_x
		var newPoint = Vector2(newPoint_x, 0)
		#Revert invY
		vB = Vector2(vBx, -vBy)
		return get_ball_y(newPoint, vB, bSize)
	elif newB_y > ProjectSettings.get_setting("globals/height"):
		var newPoint_x = (abs(ProjectSettings.get_setting("globals/height") - B_y)/vBy) * vBx + B_x
		var newPoint = Vector2(newPoint_x, ProjectSettings.get_setting("globals/height"))
		#Revert invY
		vB = Vector2(vBx, -vBy)
		return get_ball_y(newPoint, vB, bSize)
	else:
		return Vector2(Player.get_position()[0], newB_y)
	
			
func _process(delta):
	var target_point = 0
	if difficulty == 0 or difficulty == 1 and Ball.speed[0] > 0 and Ball.speedFactor > 0 or difficulty == 1 and Ball.speed[0] < 0 and Ball.speedFactor < 0:
		var rel_enterpoint = (Player.get_position() - Ball.get_position())[1] / 100
		target_point = 0.3
		if Player.speed > target_point:
			if rel_enterpoint < target_point:
				Player.move_down(delta)
			elif rel_enterpoint > target_point:
				Player.move_up(delta)
		else:
			if rel_enterpoint > target_point:
				Player.move_down(delta)
			elif rel_enterpoint < target_point:
				Player.move_up(delta)
	elif difficulty == 2:
		if Ball.speed != Vector2(0,0) and Ball.speed[0] != 0 and not calculated and Ball.get_position()[0] < Player.get_position()[0]:
			go_to_point = get_ball_y(Ball.get_position(), Ball.speed, Ball.size)
			dtarget.set_position(go_to_point)
			calculated = true
		elif Ball.speed == Vector2(0,0):
			go_to_point = Vector2(Player.get_position()[0], ProjectSettings.get_setting("globals/height") / 2)
			dtarget.set_position(go_to_point)
		if Player.speed > 0:
			if Player.get_position()[1] < go_to_point[1]:
				Player.move_down(delta)
			elif Player.get_position()[1] > go_to_point[1]:
				Player.move_up(delta)
		else:
			if Player.get_position()[1] > go_to_point[1]:
				Player.move_down(delta)
			elif Player.get_position()[1] < go_to_point[1]:
				Player.move_up(delta)


func _on_Ball_collide_with_something():
	calculated = false


func _on_Player_collision_detected():
	calculated = false
