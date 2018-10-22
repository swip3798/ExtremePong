extends Control


func _ready():
	get_node("Heavy").set_text("WTF")
	get_node("Medium").set_text("Casual")
	get_node("light").set_text("Nooby")
	if ProjectSettings.has_setting("globals/ai_difficulty"):
		var i = ProjectSettings.get_setting("globals/ai_difficulty")
		if i == 0:
			get_node("light").pressed = true
		elif i == 1:
			get_node("Medium").pressed = true
		else:
			get_node("Heavy").pressed = true

func _on_Heavy_button_up():
	ProjectSettings.set_setting("globals/ai_difficulty", 2)
	ProjectSettings.save()


func _on_light_button_up():
	ProjectSettings.set_setting("globals/ai_difficulty", 0)
	ProjectSettings.save()


func _on_Medium_button_up():
	ProjectSettings.set_setting("globals/ai_difficulty", 1)
	ProjectSettings.save()


func _on_Difficulty_focus_entered():
	get_node("Heavy").grab_focus()
