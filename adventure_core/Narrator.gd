extends Control

signal on_finish()

func _ready():
	$Button.connect("button_down",self,"on_button_skip")
	$Button/AnimationPlayer.play("idle")

func clear_narrator():
	$VBox/Image.visible = false
	$VBox/Title.visible = false
	$VBox/Desc.percent_visible = 0
	$Button.visible = false
	$VBox/Desc.text = ""
	
func start_narrator():
	$VBox/Title/Label.text = "Un rescate inesperado"
	var data = GC.get_current_room_data()
	$Tween.remove_all()
	$VBox/Desc.bbcode_text = "[center]"+data.desc+"[/center]"
	var time_read = data.desc.length()/30
	if data.isShowed: time_read = 0.3
	else: data.isShowed = true
	$Button.visible = true
	if data.image: 
		$VBox/Image.visible = true
		$VBox/Image.modulate = Color(1,1,1,0)
		$VBox/Image.texture = data.image
		$Tween.interpolate_property($VBox/Image,"modulate",Color(1,1,1,.3),Color(1,1,1,1),.3,Tween.TRANS_LINEAR, Tween.EASE_IN)
	if "title" in data: 
		$VBox/Title/Label.text = data.title
		$VBox/Title.visible = true
		var dX = $VBox/Title/Label.text.length()*13
		var cenX = $VBox/Title.rect_position.x + $VBox/Title.rect_size.x / 2 -$VBox.rect_position.x
		$VBox/Title/D1.rect_position.x = cenX - dX
		$VBox/Title/D2.rect_position.x = cenX + dX
	$Tween.interpolate_property($VBox/Desc,"percent_visible",0,1,time_read,Tween.TRANS_LINEAR, Tween.EASE_OUT)
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
