extends Control

func _ready():
	$Button.connect("button_down",self,"onStartClick")
	$Fade.fadeOut(1.2)
	yield($Fade,"end_fade")
	$btn_start.visible = true
	$Button.visible = true

func onStartClick():
	$Button.visible = false
	$btn_start.visible = false
	$Fade.fadeIn(.7)
	yield($Fade,"end_fade")
	get_tree().change_scene("res://scenes/Main.tscn")
