extends HSlider

var Unit

func _ready():
	Unit = ""
	get_node("Value").text = str(value)
	
func set_unit(unit):
	Unit = unit
	
func set_label(text):
	get_node("Label").text = text


func _on_Power_Factor_Slider_value_changed(value):
	get_node("Value").text = str(value) + Unit
