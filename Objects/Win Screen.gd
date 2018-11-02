extends Control

var globalData

func _ready():
	globalData = get_node("/root/GlobalData")
	var winner
	if globalData.getOption("winner") == "":
		winner = "What are you doing here, go away!"
	else:
		winner = globalData.getOption("winner") + " WINS!"

	get_node("WinText").text = winner
	get_node("ElementSpawner").set_scene("res://Objects/Firework.tscn")
	get_node("ElementSpawner2").set_scene("res://Objects/Firework.tscn")
	get_node("ElementSpawner3").set_scene("res://Objects/Firework.tscn")
	get_node("Back").grab_focus()
	

func _on_Back_button_up():
	get_tree().change_scene("res://Objects/Main Menu.tscn")
