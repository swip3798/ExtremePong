extends Node

var opts = {
	"winner": "",
	"ptw": 5,
	"width": 1280,
	"height": 720,
	"ai_enabled": true,
	"ai_difficulty": 1,
	"powerfactor": 5.0,
	"fullscreen": false,
	"vsync": false,
	"glow": true
}

func _ready():
	_open()
	_save()

func getOption(id):
	return opts[id]
	
func setOption(id, val):
	opts[id] = val
	_save()
	
func _save():
	var file = File.new()
	file.open("user://settings.dat", file.WRITE)
	file.store_string(to_json(opts))
	file.close()

func _open():
	var file = File.new()
	file.open("user://settings.dat", file.READ)
	var content = file.get_as_text()
	file.close()
	if validate_json(content) == "":
		opts = parse_json(content)