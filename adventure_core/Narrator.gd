extends Control

signal on_finish()

func _ready():
	pass

func clear_narrator():
	$VBox/Image.visible = false
	$VBox/Desc.percent_visible = 0
	$VBox/Desc.text = ""
	
func start_narrator():
	var data = GC.get_current_room_data()
	$VBox/Desc.text = data.desc
	if data.image: 
		$VBox/Image.visible = true
		$VBox/Image.texture = data.image
	$Tween.interpolate_property($VBox/Desc,"percent_visible",0,1,data.desc.length()/70,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	emit_signal("on_finish")
