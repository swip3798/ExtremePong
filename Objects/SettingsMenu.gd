extends Control

func _ready():
	get_node("Power Factor Slider").set_label("PowerUp Effect (how about lightning speed?)")
	get_node("btnBack").set_text("Back")
	
	if ProjectSettings.has_setting("globals/powerfactor"):
		var i = ProjectSettings.get_setting("globals/powerfactor")
		get_node("Power Factor Slider").value = i




func _on_Power_Factor_Slider_value_changed(value):
	ProjectSettings.set_setting("globals/powerfactor", value)
	ProjectSettings.save()


func _on_btnBack_button_up():
	get_tree().change_scene("res://Objects/Main Menu.tscn")
