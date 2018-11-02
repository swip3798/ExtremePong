extends WorldEnvironment

var globalData

func _ready():
	globalData = get_node("/root/GlobalData")

	if not globalData.getOption("glow"):
		environment = null

func update():
	if not globalData.getOption("glow"):
		environment = null
	else:
		environment = load("res://main menu.tres")