extends Control

func _ready():
	get_node("PointsToWin").set_label("Points to win")
	if ProjectSettings.has_setting("globals/ai_enabled"):
		if ProjectSettings.get_setting("globals/ai_enabled"):
			get_node("1 Player").pressed = true
		else:
			get_node("2 Player").pressed = true
	else:
		get_node("1 Player").pressed = true
	if ProjectSettings.has_setting("globals/ptw"):
		get_node("PointsToWin").value = ProjectSettings.get_setting("globals/ptw")
	if ProjectSettings.has_setting("globals/ai_difficulty"):
		var i = ProjectSettings.get_setting("globals/ai_difficulty")
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
	ProjectSettings.set_setting("globals/ai_enabled", true)
	ProjectSettings.save()
	


func _on_2_Player_button_up():
	ProjectSettings.set_setting("globals/ai_enabled", false)
	ProjectSettings.save()


func _on_Play_button_up():
	get_tree().change_scene("res://Objects/Level.tscn")


func _on_PointsToWin_value_changed(value):
	ProjectSettings.set_setting("globals/ptw", value)
	ProjectSettings.save()


func _on_WTF_button_up():
	ProjectSettings.set_setting("globals/ai_difficulty", 2)
	ProjectSettings.save()


func _on_Casual_button_up():
	ProjectSettings.set_setting("globals/ai_difficulty", 1)
	ProjectSettings.save()


func _on_Nooby_button_up():
	ProjectSettings.set_setting("globals/ai_difficulty", 0)
	ProjectSettings.save()
