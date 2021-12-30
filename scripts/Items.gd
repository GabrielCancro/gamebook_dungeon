extends Control

var items = {}
var items_data = {
	"sword": {"sp":"Espada", "icon":preload("res://assets/gem.png")},
}

func _ready():
	GC.Items = self
	updateItemBar()

func takeItem(obj,clickArea):
	clickArea.queue_free()
	$TweenTake.interpolate_property( obj, "position", 
	obj.position, Vector2(GC.screen.x/2,100), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$TweenTake.interpolate_property( obj, "modulate", 
	obj.modulate, Color(1,1,1,0), .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenTake.start()
	yield($TweenTake,"tween_all_completed")
	items[obj.name] = obj.name
	obj.queue_free()
	updateItemBar()

func updateItemBar():
	var keys = items.keys()
	for i in range(6): 
		if(i<keys.size()):
			(get_node("it"+str(i+1)) as Button).icon = items_data[ keys[i] ].icon
		else:
			(get_node("it"+str(i+1)) as Button).icon = null
