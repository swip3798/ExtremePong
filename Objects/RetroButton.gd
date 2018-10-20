extends TextureButton


func _ready():
	get_node("Label").text = name

func set_text(label):
	get_node("Label").text = label

func _on_RetroButton_button_down():
	get_node("Label").modulate = Color("000000")


func _on_RetroButton_button_up():
	get_node("Label").modulate = Color("ffffff")
