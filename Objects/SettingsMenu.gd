extends Control

func _ready():
	get_node("Power Factor Slider").set_label("PowerUp Effect (how about lightning speed?)")
	get_node("btnBack").set_text("Back")
	
	if ProjectSettings.has_setting("globals/powerfactor"):
		var i = ProjectSettings.get_setting("globals/powerfactor")
		get_node("Power Factor Slider").value = i
	if ProjectSettings.has_setting("globals/glow"):
		var i = ProjectSettings.get_setting("globals/glow")
		get_node("Glow").pressed = i
	else:
		get_node("Glow").pressed = true
	get_node("Vsync").pressed = OS.is_vsync_enabled()
	get_node("Fullscreen").pressed = OS.is_window_fullscreen()
	get_node("Power Factor Slider").grab_focus()




func _on_Power_Factor_Slider_value_changed(value):
	ProjectSettings.set_setting("globals/powerfactor", value)
	ProjectSettings.save()


func _on_btnBack_button_up():
	get_tree().change_scene("res://Objects/Main Menu.tscn")


func _on_Fullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
	ProjectSettings.set_setting("globals/fullscreen", button_pressed)
	ProjectSettings.save()


func _on_Vsync_toggled(button_pressed):
	OS.set_use_vsync(button_pressed)
	ProjectSettings.set_setting("globals/vsync", button_pressed)
	ProjectSettings.save()


func _on_Glow_toggled(button_pressed):
	ProjectSettings.set_setting("globals/glow", button_pressed)
	ProjectSettings.save()
	get_node("WorldEnvironment").update()
