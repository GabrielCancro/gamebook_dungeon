extends Node2D

func _ready():
	GC.Game = self
	$btn_main.connect("button_down",self,"onClick",["main"])
	$btn_inventory.connect("button_down",self,"onClick",["inv"])
	for i in range(4):
		$Options/HBox.get_node("op"+str(i+1)).connect("button_down",self,"onClick",["op",str(i+1)])
	GC.RoomManager.gotoRoom("001")

func onClick(arg,opt=null):
	if arg=="main": get_tree().change_scene("res://scenes/Main.tscn")
	if arg=="inv": $Inventory.show()
	if arg=="op" and GC.RoomManager.currentRoom.has_method("onOption"): GC.RoomManager.currentRoom.onOption(opt)

func show_desc(text):
	$Desc.text = text
	$Options.modulate.a = 0
	$Options/Tween.stop_all()
	$Desc/Tween.interpolate_property($Desc, "percent_visible",
		0, 1, 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Desc/Tween.start()
	yield($Desc/Tween,"tween_completed")
	show_options()

func show_options():
	for i in range(4): $Options/HBox.get_node("op"+str(i+1)).visible = false
	var room = GC.RoomManager.currentRoom
	if "options" in room:
		for i in room.options.size():
			$Options/HBox.get_node("op"+str(i+1)).visible = true
			$Options/HBox.get_node("op"+str(i+1)).text = room.options[i][GC.lang]
	$Options/Tween.interpolate_property($Options, "modulate",
		Color(1,1,1,0), Color(1,1,1,1), .2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Options/Tween.start()
