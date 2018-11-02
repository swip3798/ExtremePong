extends Control

var globalData

func _ready():

	globalData = get_node("/root/GlobalData")

	get_node("Heavy").set_text("WTF")
	get_node("Medium").set_text("Casual")
	get_node("light").set_text("Nooby")
	var i = globalData.getOption("ai_difficulty")
	if i == 0:
		get_node("light").pressed = true
	elif i == 1:
		get_node("Medium").pressed = true
	else:
		get_node("Heavy").pressed = true

func _on_Heavy_button_up():
	globalData.setOption("ai_difficulty", 2)


func _on_light_button_up():
	globalData.setOption("ai_difficulty", 0)


func _on_Medium_button_up():
	globalData.setOption("ai_difficulty", 1)


func _on_Difficulty_focus_entered():
	get_node("Heavy").grab_focus()
