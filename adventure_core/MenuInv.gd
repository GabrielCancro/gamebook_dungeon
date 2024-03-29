extends Control

var start_rect_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_menu.connect("button_down",self,"show_menu")
	$NinePatchRect/btn_continue.connect("button_down",self,"hide_menu")
	$NinePatchRect/btn_quit.connect("button_down",self,"goto_menu")
	for b in $NinePatchRect/GridContainer.get_children():
		b.text = str(b.get_index()).pad_zeros(3)
		b.connect("button_down",self,"on_grid_click",[b])

func show_menu():
	if !start_rect_position: start_rect_position = $NinePatchRect.rect_position
	$ColorRect.modulate.a = 0
	$ColorRect.visible = true
	var end_pos = Vector2($NinePatchRect.rect_position.x,-150)
	$Tween.interpolate_property($ColorRect,"modulate",$ColorRect.modulate,Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property($NinePatchRect,"rect_position",$NinePatchRect.rect_position,end_pos,.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	set_inv_label()

func set_inv_label():
	$NinePatchRect/ScrollContainer/Label_inv.text = "INVENTARIO:\n"
	if(GC.ADV_DATA.items.keys().size()<=0): $NinePatchRect/ScrollContainer/Label_inv.text = "INVENTARIO (vacío)"
	for obj_id in GC.ADV_DATA.items:
		var obj = GC.ADV_DATA.items[obj_id]
		$NinePatchRect/ScrollContainer/Label_inv.text += "\n- " + obj.name + ": " + obj.desc+ "\n"

func hide_menu():
	$Tween.interpolate_property($ColorRect,"modulate",$ColorRect.modulate,Color(1,1,1,0),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property($NinePatchRect,"rect_position",$NinePatchRect.rect_position,start_rect_position,.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$ColorRect.visible = false

func goto_menu():
	get_tree().change_scene("res://scenes/Main.tscn")

func on_grid_click(b):
	print( "room_"+b.text )
	GC.ADVENTURE.change_room("room_"+b.text)
	hide_menu()
