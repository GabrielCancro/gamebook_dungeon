extends Node2D

func _ready():
	GC.Game = self	
	$btn_main.connect("button_down",self,"onClick",["main"])
	$btn_inventory.connect("button_down",self,"onClick",["inv"])
	for i in range(4): $Options/HBox.get_node("op"+str(i+1)).connect("button_down",self,"onClick",["op",str(i+1)])
	for i in range(6): $Items.get_node("it"+str(i+1)).connect("button_down",self,"onItemClick",[i])
	$Items/Label.visible = false
	$Items/Selector.visible = false
	GC.item_selected = -1
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
	for i in range(4):
		if !"op"+str(i+1) in room.data: break
		$Options/HBox.get_node("op"+str(i+1)).visible = true
		$Options/HBox.get_node("op"+str(i+1)).text = room.data["op"+str(i+1)][GC.lang]
	$Options/Tween.interpolate_property($Options, "modulate",
		Color(1,1,1,0), Color(1,1,1,1), .2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Options/Tween.start()

func onItemClick(i):
	GC.item_selected = i
	$Items/Label.visible = true
	$Items/Selector.visible = true
	$Items/Selector.position.x = $Items.get_node("it"+str(i+1)).rect_position.x+40

func _input(event):
	if event.is_pressed() and event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if GC.item_selected != -1: onItemUse(event.position)

func onItemUse(pos):
	print("USE IN ",pos)
	$Items/Label.visible = false
	$Items/Selector.visible = false
	GC.showFloatText("No sirve\nde nada aqui..", pos)
	GC.item_selected = -1
