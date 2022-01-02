extends Node2D

var title = {
	"sp": "Rescata al príncipe"
}
var text = {
	"sp":"""Caminas por el bosque cuando escuchas un grito. Corres en su dirección y te encuentras con dos guardias malheridos. 
	Son guardias reales. Uno de ellos parece seguir con vida y te pide ayuda. Escoltaban al príncipe a través del bosque cuando encontraron una cueva. El príncipe quiso explorar pero sus guardias se lo negaron. Y mientras hablaban, una criatura salió, los atacó y se llevó al príncipe. 
	
	Encuentra al príncipe y tendrás nuestra gratitud.
	"""
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_next.visible = false
	$btn_next.connect("button_down",self,"onClickNext")
	$Desc.text = text[GC.lang]
	$Label.text = title[GC.lang]
	$ColorRect.visible = true
	$Desc.percent_visible = 0
	$ColorRect/Tween.interpolate_property($ColorRect,"modulate",Color(1,1,1,1),Color(1,1,1,0),.7,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$ColorRect/Tween.start()
	yield($ColorRect/Tween,"tween_all_completed")
	
	$ColorRect.visible = false	
	$Desc/Tween.interpolate_property($Desc,"percent_visible",0,1,12,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Desc/Tween.start()
	yield(get_tree().create_timer(1), "timeout")
	$btn_next.visible = true

func onClickNext():
	$ColorRect.visible = true
	$ColorRect/Tween.interpolate_property($ColorRect,"modulate",Color(1,1,1,0),Color(1,1,1,1),1.5,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$ColorRect/Tween.start()
	yield($ColorRect/Tween,"tween_all_completed")
	get_tree().change_scene("res://scenes/Game.tscn")
