extends Control

signal on_close

func _ready():
	GC.POPUP = self
	visible = false
	$Button.connect("button_down",self,"close_popup")

func show_popup(txt,addItem=null):
	self.modulate = Color(1,1,1,0)
	visible = true
	$Button.visible = false
	$Label.text = txt
	$Item.visible = false
	if addItem: 
		GC.add_item(addItem) 
		$Item.texture = load("res://adventures/"+GC.ADVENTURE_FOLDER+"/imgs/"+GC.get_item(addItem).img+".png")
		$Item.visible = true
		$Label.text +="\n\n+Nuevo objeto adquirido+"
		$Label.text +="\n"+GC.get_item(addItem).name
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	$Button.visible = true
	

func close_popup():
	$Button.visible = false
	GC.DESITIONS.update_data(true)
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,1),Color(1,1,1,.5),.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	$Tween.remove_all()
	visible = false
	emit_signal("on_close")
	
