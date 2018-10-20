extends TextureButton

var text


func _ready():
	get_node("Label").text = name

func set_text(label):
	get_node("Label").text = label

