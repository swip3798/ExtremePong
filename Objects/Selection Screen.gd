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
