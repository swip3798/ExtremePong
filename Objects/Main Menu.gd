extends Control

func _ready():
	ProjectSettings.set_setting("globals/width", 1280)
	ProjectSettings.set_setting("globals/height", 720)
	if ProjectSettings.has_setting("globals/vsync"):
		OS.set_use_vsync(ProjectSettings.get_setting("globals/vsync"))
	if ProjectSettings.has_setting("globals/fullscreen"):
		OS.set_window_fullscreen(ProjectSettings.get_setting("globals/fullscreen"))
	get_node("PlayButton").set_text("Play")
	get_node("Settings").set_text("Settings")
	get_node("Exit").set_text("Exit")
	get_node("PlayButton").focus_mode = get_node("PlayButton").FOCUS_ALL
	get_node("Settings").focus_mode = get_node("Settings").FOCUS_ALL
	get_node("Exit").focus_mode = get_node("Exit").FOCUS_ALL
	get_node("PlayButton").grab_focus()


func _on_Main_Menu_gui_input(ev):
	if ev.is_pressed():
		print("click")


func _on_Title_gui_input(ev):
	if ev.is_pressed():
		print("label click")


func _on_Exit_button_up():
	get_tree().quit()


func _on_Settings_button_up():
	get_tree().change_scene("res://Objects/SettingsMenu.tscn")


func _on_PlayButton_button_up():
	get_tree().change_scene("res://Objects/Selection Screen.tscn")


func _on_Credits_button_up():
	get_tree().change_scene("res://Objects/Credits.tscn")
