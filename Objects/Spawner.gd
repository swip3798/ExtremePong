extends Timer

var level

var globalData

func _ready():
	globalData = get_node("/root/GlobalData")
	level = get_parent()
	var time = randf()*4 + 1.5
	set_wait_time(time)
	start()


func _on_Spawner_timeout():
	randomize()
	var powerup = preload("res://Objects/PowerUP.tscn").instance()
	powerup.set_position(Vector2(rand_range(300, globalData.getOption("width") - 300), randf() * globalData.getOption("height")))
	powerup.set_z_index(-1)
	add_child(powerup)
	var time = randf()*4 + 1.2
	set_wait_time(time)