extends Control

var globalData

func _ready():
	globalData = get_node("/root/GlobalData")
	get_node("Power Factor Slider").set_label("PowerUp Effect (how about lightning speed?)")
	get_node("btnBack").set_text("Back")
	
	get_node("Power Factor Slider").value = globalData.getOption("powerfactor")
	get_node("Glow").pressed = globalData.getOption("glow")
	get_node("Vsync").pressed = OS.is_vsync_enabled()
	get_node("Fullscreen").pressed = OS.is_window_fullscreen()
	get_node("Power Factor Slider").grab_focus()

func _process(delta):
	if Input.is_action_pressed("ui_move_back"):
		_on_btnBack_button_up()


func _on_Power_Factor_Slider_value_changed(value):
	globalData.setOption("powerfactor", value)


func _on_btnBack_button_up():
	get_tree().change_scene("res://Objects/Main Menu.tscn")


func _on_Fullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
	globalData.setOption("fullscreen", button_pressed)


func _on_Vsync_toggled(button_pressed):
	OS.set_use_vsync(button_pressed)
	globalData.setOption("vsync", button_pressed)


func _on_Glow_toggled(button_pressed):
	globalData.setOption("glow", button_pressed)
	get_node("WorldEnvironment").update()
