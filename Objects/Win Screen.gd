extends Control

func _ready():
	var winner = "What are you doing here, go away!"
	if ProjectSettings.has_setting("globals/winner"):
		winner = ProjectSettings.get_setting("globals/winner") + " WINS!"
	get_node("WinText").text = winner
	get_node("ElementSpawner").set_scene("res://Objects/Firework.tscn")
	get_node("ElementSpawner2").set_scene("res://Objects/Firework.tscn")
	get_node("ElementSpawner3").set_scene("res://Objects/Firework.tscn")
	get_node("Back").grab_focus()
	

func _on_Back_button_up():
	get_tree().change_scene("res://Objects/Main Menu.tscn")
