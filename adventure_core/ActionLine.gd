extends Control

var data
signal on_click


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onClick")
	rect_min_size.y = (1+floor($Desc.text.length()/28)) * 30 + 30
	print(rect_min_size.y)

func set_node_data(_data):
	print("NODE",_data)
	data = _data
	$Desc.text = _data.text
	rect_pivot_offset = rect_size/2
	
	if "isNew" in data && data.isNew:
		data.isNew = false
		$TextureRect.modulate = Color(.8,.8,1,1)

	$diceIcon.visible = false
	if data.has("isDice"):
		$diceIcon.visible = true
		$diceIcon.texture = load("res://assets/ui/dices_icon_"+str(data.isDice)+".png")

func onClick():
	GC.CURRENT_NODE = data
	GC.add_click_fx(self)
	emit_signal("on_click",data)
