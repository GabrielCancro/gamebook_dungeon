extends Control

var is_open = false

func _ready():
	$btn_openclose.connect("button_down",self,"on_click_openclose")	
	$Options.rect_size.y = 0
	rect_position.y = get_parent().rect_size.y + $Options.rect_size.y
	yield(get_tree().create_timer(.1),"timeout")

func open_options():
	rect_size.y = $Options.rect_size.y + 200
	var open_pos = Vector2(rect_position.x, get_parent().rect_size.y - rect_size.y)
	$Tween.interpolate_property(self,"rect_position",rect_position,open_pos,.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	is_open = true

func close_options():
	var close_pos = Vector2(rect_position.x, get_parent().rect_size.y - 70)
	$Tween.interpolate_property(self,"rect_position",rect_position,close_pos,.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	is_open = false

func on_click_openclose():
	if is_open: close_options()
	else: open_options()
