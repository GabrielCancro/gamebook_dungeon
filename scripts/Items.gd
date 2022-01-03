extends Control

var item_selected = -1
var items = []
var items_data = {
	"sword": {"sp":"Espada", "icon":preload("res://assets/items/iconEspada.png")},
}

func _ready():
	GC.Items = self
	for i in range(6): 
		get_node("it"+str(i+1)).connect("button_down",self,"onItemClick",[i])
#		get_node("it"+str(i+1)).rect_position.x = i*110
	$Label.visible = false
	$Selector.visible = false
	updateItemBar()

func takeItem(obj,clickArea):
	clickArea.queue_free()
	$TweenTake.interpolate_property( obj, "position", 
	obj.position, Vector2(GC.screen.x/2,100), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$TweenTake.interpolate_property( obj, "modulate", 
	obj.modulate, Color(1,1,1,0), .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenTake.start()
	yield($TweenTake,"tween_all_completed")
	items.append(obj.name)
	obj.queue_free()
	updateItemBar()

func updateItemBar():
	for i in range(6): 
		if(i<items.size()):
			(get_node("it"+str(i+1)) as Button).icon = items_data[ items[i] ].icon
		else:
			(get_node("it"+str(i+1)) as Button).icon = null

func onItemClick(i):
	if(i<items.size()):
		item_selected = i
		$Label.visible = true
		$Label.text = "Elige donde usar tu " + items_data[ items[i] ][GC.lang]
		$Selector.visible = true
		$Selector.position.x = get_node("it"+str(i+1)).rect_position.x+$it1.rect_size.x/2
	else:
		item_selected = -1
		$Label.visible = false
		$Selector.visible = false

func _input(event):
	if event.is_pressed() and event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if item_selected != -1: onItemUse(event.position)

func onItemUse(pos):
	print("USE IN ",pos)
	$Label.visible = false
	$Selector.visible = false	
	yield(get_tree().create_timer(.05), "timeout")
	if item_selected == -1: return
	GC.showFloatText("No sirve\nde nada aqui..", pos)
	item_selected = -1
	
func useItem(nameItem,mode):
	if item_selected == -1: return
	if items[item_selected] == nameItem:
		if mode == "delete": items.erase(items[item_selected])
		item_selected = -1
		updateItemBar()
		return true
