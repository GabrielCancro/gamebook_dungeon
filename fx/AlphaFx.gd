extends Node2D

export var start = .3
export var end = .6
export var duration = 1

func _ready():
	start_tween()

func start_tween():
	$Tween.remove_all()
	$Tween.interpolate_property(get_parent(),"modulate",get_parent().modulate,Color(1,1,1,end),duration,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$Tween.interpolate_property(get_parent(),"modulate",get_parent().modulate,Color(1,1,1,start),duration,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	start_tween()
