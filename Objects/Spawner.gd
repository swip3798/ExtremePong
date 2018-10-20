extends Timer

var level

func _ready():
	level = get_parent()
	var time = randf()*4 + 1.5
	set_wait_time(time)
	start()


func _on_Spawner_timeout():
	randomize()
	var powerup = preload("res://Objects/PowerUP.tscn").instance()
	powerup.set_position(Vector2(rand_range(300, ProjectSettings.get_setting("globals/width") - 300), randf() * ProjectSettings.get_setting("globals/height")))
	powerup.set_z_index(-1)
	add_child(powerup)
	var time = randf()*4 + 1.2
	set_wait_time(time)