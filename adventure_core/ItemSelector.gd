extends Control

var current_item_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onMainButtonClick")
	hide_menu()

func show_menu():
	$Back.visible = true
	$Next.visible = true
	$Line.visible = true
	$ArrowLeft.visible = true
	$ArrowRight.visible = true
	update_data()

func hide_menu():
	$Back.visible = false
	$Next.visible = false
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
		$Line/Desc.text = GC.ADV_DATA.items[key].desc
