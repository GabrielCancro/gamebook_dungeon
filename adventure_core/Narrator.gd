extends Control

signal on_finish()

func _ready():
	$Button.connect("button_down",self,"on_button_skip")

func clear_narrator():
	$VBox/Image.visible = false
	$VBox/Desc.percent_visible = 0
	$Button.visible = false
	$VBox/Desc.text = ""
	
func start_narrator():
	var data = GC.get_current_room_data()
	$VBox/Desc.text = data.desc
	$Button.visible = true
	if data.image: 
		$VBox/Image.visible = true
		$VBox/Image.modulate = Color(1,1,1,0)
		$VBox/Image.texture = data.image
		$Tween.interpolate_property($VBox/Image,"modulate",Color(1,1,1,.3),Color(1,1,1,1),.3,Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property($VBox/Desc,"percent_visible",0,1,data.desc.length()/30,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$Button.visible = false
	emit_signal("on_finish")

func on_button_skip():
	$Tween.stop_all()
	$VBox/Desc.percent_visible = 1
	$Button.visible = false
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("on_finish")
