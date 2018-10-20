extends WorldEnvironment

func _ready():
	if ProjectSettings.has_setting("globals/glow"):
		if not ProjectSettings.get_setting("globals/glow"):
			environment = null

func update():
	if ProjectSettings.has_setting("globals/glow"):
		if not ProjectSettings.get_setting("globals/glow"):
			environment = null
		else:
			environment = load("res://main menu.tres")