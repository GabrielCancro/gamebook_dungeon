extends Control

signal end_fade

func _ready():
	visible = true

func fadeIn(time=.3, delay=0):
	visible = true
	$Tween.interpolate_property($ColorRect,"modulate",$ColorRect.modulate,Color(1,1,1,1),time,Tween.TRANS_LINEAR,Tween.EASE_IN,delay)
	$Tween.start()
	yield(get_tree().create_timer(time+delay),"timeout")
	emit_signal("end_fade")

func fadeOut(time=.3, delay=0):
	$Tween.interpolate_property($ColorRect,"modulate",$ColorRect.modulate,Color(1,1,1,0),time,Tween.TRANS_LINEAR,Tween.EASE_IN,delay)
	$Tween.start()
	yield(get_tree().create_timer(time+delay),"timeout")
	visible = false
	emit_signal("end_fade")

#func forceVisible(_visible):
#	visible = _visible
#	if visible: $ColorRect.modulate = Color(1,1,1,1)
#	else: $ColorRect.modulate = Color(1,1,1,0)
