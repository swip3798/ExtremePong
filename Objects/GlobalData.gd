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

func getOption(id):
	return opts[id]
	
func setOption(id, val):
	opts[id] = val