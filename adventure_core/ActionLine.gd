extends Label

var data
signal on_click


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onClick")

func set_node_data(_data):
	print("NODE",_data)
	data = _data
	text = data.text
	$Desc.text = text
	rect_pivot_offset = rect_size/2
	$diceIcon.visible = data.has("isDice") && data.isDice
	$rerollIcon.visible = data.has("isReroll") && data.isReroll

func onClick():
	GC.CURRENT_NODE = data
	emit_signal("on_click",data)
