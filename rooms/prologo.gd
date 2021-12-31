extends Node2D

var text = {
	"sp":"""
	 	Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
	 	bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
	 	bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla
	"""
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.visible = true
	$Desc.percent_visible = 0
	$ColorRect/Tween.interpolate_property($ColorRect,"modulate",Color(1,1,1,1),Color(1,1,1,0),.7,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$ColorRect/Tween.start()
	yield($ColorRect/Tween,"tween_all_completed")
	$ColorRect.visible = false
	
	$btn_next.visible = false
	$btn_next.connect("button_down",self,"onClickNext")
	$Desc.text = text[GC.lang]
	$Desc/Tween.interpolate_property($Desc,"percent_visible",0,1,7,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Desc/Tween.start()
	yield(get_tree().create_timer(4), "timeout")
	$btn_next.visible = true

func onClickNext():
	$ColorRect.visible = true
	$ColorRect/Tween.interpolate_property($ColorRect,"modulate",Color(1,1,1,0),Color(1,1,1,1),1.5,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$ColorRect/Tween.start()
	yield($ColorRect/Tween,"tween_all_completed")
	get_tree().change_scene("res://scenes/Game.tscn")
