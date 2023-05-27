extends Control

var current_item_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onMainButtonClick")
	$ArrowLeft.connect("button_down",self,"onLeftButtonClick") 
	hide_menu()

func show_menu():
	$Line.visible = true
	$ArrowLeft.visible = true
	$ArrowRight.visible = true
	update_data()

func hide_menu():
	$Line.visible = false
	$ArrowLeft.visible = false
	$ArrowRight.visible = false

func onMainButtonClick():
	if $Line.visible: hide_menu()
	else: show_menu()

func update_data():
	var size = GC.ADV_DATA.items.keys().size()
	if current_item_index<0: current_item_index = 0
	if current_item_index>=size: current_item_index = size -1
	if current_item_index < 0: $Line/Desc.text = "No tienes ningun objeto en tu mochila"
	else:
		var key = GC.ADV_DATA.items.keys()[current_item_index]
		var data = GC.ADV_DATA.items[key]
		$Line/Desc.text = data.desc
		if data.img: $Line/Icon.texture = load("res://adventures/"+GC.ADVENTURE_FOLDER+"/imgs/"+data.img+".png")
		else: $Line/Icon.texture = null

func onLeftButtonClick():
#	$Tween.interpolate_property($Line,"rect_position",s_pos["Line"],s_pos["Line"]+Vector2(-50,0),.2)
	$Tween.interpolate_property($Line,"modulate",Color(1,1,1,1),Color(1,1,1,.5),.2)
	$Tween.start();
	yield($Tween,"tween_all_completed")
	current_item_index -= 1
	if current_item_index < 0: current_item_index = GC.ADV_DATA.items.keys().size()-1
	update_data()
#	$Tween.interpolate_property($Line,"rect_position",s_pos["Line"]+Vector2(0,+50),s_pos["Line"],.2)
	$Tween.interpolate_property($Line,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.2)
	$Tween.start();
	
