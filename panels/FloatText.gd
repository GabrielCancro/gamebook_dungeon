extends Label

func _ready():
	GC.RoomManager.connect("change_room",self,"onChangeRoom")
	pass

func showText(_text,_pos):
	text = _text
	rect_position = _pos
	if rect_position.x < 0: rect_position.x = 0
	if rect_position.x > GC.screen.x-rect_size.x: rect_position.x = GC.screen.x-rect_size.x
	yield(get_tree().create_timer(.2 + 30/text.length()), "timeout")
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,1), 
	Color(0,0,0,0), .5,Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	queue_free()

func onChangeRoom(): 
	queue_free()
