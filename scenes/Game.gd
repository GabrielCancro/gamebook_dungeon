extends Node2D

func _ready():
	GC.Game = self
	$btn_menu.connect("button_down",self,"onClick",["menu"])
	for i in range(4): $Options/HBox.get_node("op"+str(i+1)).connect("button_down",self,"onClick",["op",str(i+1)])
	GC.RoomManager.gotoRoom("r001")

func onClick(arg,opt=null):
	if arg=="menu": $Inventory.show()
	if arg=="op" and GC.RoomManager.currentRoom.has_method("onOption"): GC.RoomManager.currentRoom.onOption(opt)

func show_desc(text,time=2):
	$Desc.text = text
	$Options.modulate.a = 0
	$Options/Tween.stop_all()
	$Desc/Tween.interpolate_property($Desc, "percent_visible",
		0, 1, time,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Desc/Tween.start()
	yield($Desc/Tween,"tween_completed")
	show_options()

func show_options():
	for i in range(4): $Options/HBox.get_node("op"+str(i+1)).visible = false
	var room = GC.RoomManager.currentRoom
	for i in range(4):
		if !"op"+str(i+1) in room.data: break
		$Options/HBox.get_node("op"+str(i+1)).visible = true
		$Options/HBox.get_node("op"+str(i+1)).text = room.data["op"+str(i+1)][GC.lang]
	$Options/Tween.interpolate_property($Options, "modulate",
		Color(1,1,1,0), Color(1,1,1,1), .2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Options/Tween.start()
