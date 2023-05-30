extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onStartClick")
	$PageImg.modulate.a = 0
	$btn_start.modulate.a = 0
	$Button.visible = false
	$Tween.interpolate_property($PageImg,"modulate",$PageImg.modulate,Color(1,1,1,1),2)
	$Tween.start()
	yield($Tween,"tween_completed")
	$Button.visible = true
	$Tween.interpolate_property($btn_start,"modulate",$PageImg.modulate,Color(1,1,1,1),.5)
	$Tween.start()

func onStartClick():
	$Button.visible = false
	$btn_start.modulate.a = 0
	$Tween.interpolate_property($PageImg,"modulate",$PageImg.modulate,Color(1,1,1,0),1)
	$Tween.start()
	yield($Tween,"tween_completed")
	get_tree().change_scene("res://scenes/Main.tscn")
