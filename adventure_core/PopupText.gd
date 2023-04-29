extends Control

var next_show_dice_result = false
var result_deco = {
		"P":"PÍFIA",
		"F":"FALLO",
		"EP":"ÉXITO PARCIAL",
		"E":"ÉXITO",
		"EA":"ÉXITO ABSOLUTO"
	}

signal on_close

func _ready():
	GC.POPUP = self
	visible = false
	$NinePatchRect/Button.connect("button_down",self,"close_popup")

func set_dice_result(val,result_data = {"0":"F"}):
	if val==null: 
		next_show_dice_result = false
		return
	var result
	for i in result_data.keys(): if val >= int(i): result = result_data[i]
	next_show_dice_result = true
	$lb_result.text = str(val)
	$lb_result/lb_result_text.text = result_deco[result]
	return result
	
func show_popup(txt,anim=true):
	visible = true
	self.modulate = Color(1,1,1,1)
	$NinePatchRect/Button.disabled = false
	$lb_result.visible = next_show_dice_result
	$NinePatchRect/Label.text = txt
	$NinePatchRect.rect_size.y = $NinePatchRect/Label.rect_size.y * 1.2
	if anim:
		$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.start()
	return self

func close_popup():
	$NinePatchRect/Button.disabled = true
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,1),Color(1,1,1,0),.4,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	visible = false
	emit_signal("on_close")
