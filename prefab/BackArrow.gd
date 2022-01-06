extends Area2D

signal onClickArea
var dir = 1.1

func _process(delta):
	if(scale.x > 1.2): dir = .99
	if(scale.x < 1): dir = 1.01
	scale *= dir

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		emit_signal("onClickArea",get_parent())
		if(get_parent().has_method("onClickAreaMethod")): get_parent().onClickAreaMethod(name)
