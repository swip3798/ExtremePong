extends Timer

var res
var activate

func _ready():
	randomize()
	wait_time = rand_range(0.3, 0.8)
	activate = false
	
func set_scene(path):
	res = load(path)
	start()
	

func _on_ElementSpawner_timeout():
	var explosion = res.instance()
	randomize()
	var position = Vector2(rand_range(0, ProjectSettings.get_setting("globals/width")), rand_range(0, ProjectSettings.get_setting("globals/height")))
	explosion.set_position(position)
	explosion.set_z_index(-1)
	add_child(explosion)
	wait_time = rand_range(0.7, 1.3)
