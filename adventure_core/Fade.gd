extends Control

signal end_fade


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true

func fadeIn():
	visible = true
	$Tween.interpolate_property($ColorRect,"modulate",$ColorRect.modulate,Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	emit_signal("end_fade")

func fadeOut():
	$Tween.interpolate_property($ColorRect,"modulate",$ColorRect.modulate,Color(1,1,1,0),.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	visible = false
	emit_signal("end_fade")
