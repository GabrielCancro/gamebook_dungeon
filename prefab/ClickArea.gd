extends Area2D

signal onClickArea

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		emit_signal("onClickArea",get_parent())
		if(get_parent().has_method("onClickAreaMethod")): get_parent().onClickAreaMethod(name)
