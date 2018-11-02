extends Control

var globalData

func _ready():
	globalData = get_node("/root/GlobalData")
	get_node("PointsToWin").set_label("Points to win")
	if globalData.getOption("ai_enabled"):
		get_node("1 Player").pressed = true
	else:
		get_node("2 Player").pressed = true

	get_node("PointsToWin").value = globalData.getOption("ptw")
	var i = globalData.getOption("ai_difficulty")
	if i == 0:
		get_node("Nooby").pressed = true
	elif i == 1:
		get_node("Casual").pressed = true
	else:
		get_node("WTF").pressed = true
	get_node("Play").grab_focus()
	
func _process(delta):
	if Input.is_action_pressed("ui_move_back"):
		go_back()

func go_back():
	get_tree().change_scene("res://Objects/Main Menu.tscn")
	
func _on_1_Player_button_up():
	globalData.setOption("ai_enabled", true)


func _on_2_Player_button_up():
	globalData.setOption("ai_enabled", false)


func _on_Back_button_up():
	go_back()

func _on_Play_button_up():
	get_tree().change_scene("res://Objects/Level.tscn")


func _on_PointsToWin_value_changed(value):
	globalData.setOption("ptw", value)


func _on_WTF_button_up():
	globalData.setOption("ai_difficulty", 2)


func _on_Casual_button_up():
	globalData.setOption("ai_difficulty", 1)


func _on_Nooby_button_up():
	globalData.setOption("ai_difficulty", 0)
