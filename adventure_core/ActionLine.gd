extends Label

var data
signal on_click


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onClick")

func set_node_data(_data):
	data = _data
	text = data.text
	$Desc.text = text
	rect_pivot_offset = rect_size/2

func onClick():
	emit_signal("on_click",data)
