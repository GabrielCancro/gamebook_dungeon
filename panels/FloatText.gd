extends Label

func _ready():
	print(rect_position)	
	yield(get_tree().create_timer(.2 + 30/text.length()), "timeout")
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,1), 
	Color(0,0,0,0), .5,Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	queue_free()
