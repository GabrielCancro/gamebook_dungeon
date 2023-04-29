extends Control

signal on_close


# Called when the node enters the scene tree for the first time.
func _ready():
	GC.POPUP = self
	visible = false
	$NinePatchRect/Button.connect("button_down",self,"close_popup")

func show_popup(txt,anim=true):
	visible = true
	$NinePatchRect/Label.text = txt
	$NinePatchRect.rect_size.y = $NinePatchRect/Label.rect_size.y * 1.2
	if anim:
		$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.start()

func close_popup():
	visible = false
	emit_signal("on_close")