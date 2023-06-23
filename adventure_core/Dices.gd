extends Control

var dices_data = null
var conc_bonif = 0
var item_bonif = 0
var start_dices_y = 0
var dice_cost = 0
var dices_value = 0
var isRolled = false

onready var DicesResults = get_node("../DicesResults")

func _ready():
	GC.DICES = self
	randomize()
	visible = false
	$btn_roll.connect("button_down",self,"onButtonRoll")
	$btn_back.connect("button_down",self,"onButtonClose")
	$btn_add.connect("button_down",self,"onButtonAdd")
	$DiceCost/btn_cost.connect("button_down",self,"onButtonCost")

func show_dices(data):
	dices_data = data
	$DiceCost.visible = (GC.CURRENT_NODE && GC.CURRENT_NODE.isDice == 2)
	$DiceCost/btn_add/Label2.text = str(GC.ACTION_POINTS)
	$ItemSelector.hide_menu()
	$Node_text.text = GC.CURRENT_NODE.text
	$Ability/Label.text = dices_data.abName
	conc_bonif = 0
	dice_cost = 0
	set_usable_items()
	
	$btn_add/Label2.text = str(GC.ACTION_POINTS)
	$Modif/Label2.text = "+"+str(conc_bonif)
	visible = true
	isRolled = false
	$DicesRolling.hide_dices()
	$Result.visible = false
	$btn_roll.visible = true
	$btn_back.visible = true
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func onButtonRoll():
	if isRolled: return
	isRolled = true
	check_dices_type()
	$btn_roll.visible = false
	$btn_back.visible = false	
	$DicesRolling.roll()
	dices_value = yield($DicesRolling,"end_roll")
	show_result()

func onButtonClose():
	GC.ACTION_POINTS += conc_bonif + dice_cost
	visible = false

func onButtonAdd():
	if GC.ACTION_POINTS <= 0 || isRolled || conc_bonif>=5: return
	GC.ACTION_POINTS -= 1
	conc_bonif += 1
	$btn_add/Label2.text = str(GC.ACTION_POINTS)
	$Modif/Label2.text = "+"+str(conc_bonif)
	$Tween.interpolate_property($Modif,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property($btn_add,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func onButtonCost():
	$DiceCost.visible = false
	if(GC.ACTION_POINTS>=2):
		dice_cost = 2
		GC.ACTION_POINTS -= 2
		$btn_add/Label2.text = str(GC.ACTION_POINTS)
		$Tween.interpolate_property($btn_add,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.start()
	else: 
		visible = false
		GC.POPUP.show_popup("No tienes suficiente PUNTOS DE CONCENTRACIÓN para realizar esta tirada!")

func show_result():
	var value = dices_value+conc_bonif+item_bonif
	var result_desc = "F" 
	var size = dices_data.results.size()
	for i in range(size):
		if value >= dices_data.results[ dices_data.results.keys()[i] ].ran[0]: 
			if i==1: result_desc = "EP" 
			if i==size-1: result_desc = "ET"
	dices_data["result_texture"] = "res://assets/ui/Result_"+result_desc+".png"
	$Result.texture = load(dices_data.result_texture) 
	$Result/Label.text = str(value)
	$Result.visible = true
	$Result.modulate = Color(0,0,0,.2)
	$Tween.interpolate_property($Result,"modulate",$Result.modulate,Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	
	yield(get_tree().create_timer(2.2),"timeout")
	visible = false
	DicesResults.show_results(value,dices_data)

func check_dices_type():
	if(GC.CURRENT_NODE): 
		if GC.CURRENT_NODE.isDice == 1: 
			GC.CURRENT_NODE.isDice = 2
		elif GC.CURRENT_NODE.isDice == 3: 
			GC.DESITIONS.set_visible_desition(GC.CURRENT_NODE.node_id,false)
		elif GC.CURRENT_NODE.isDice == 4: 
			pass #tiradas negras pero que no desaparecen
		GC.DESITIONS.update_data(false)

func set_usable_items():
	item_bonif = 0
	$Modif/Space.visible = false
	$Modif/AddItem.visible = false
	$Modif/ItemLabel.visible = false
	if !"item" in dices_data: return
	
	var item_data = GC.get_item(dices_data["item"])
	item_bonif = 3
	$Modif/AddItem.texture = load("res://adventures/"+GC.ADVENTURE_FOLDER+"/imgs/"+item_data.img+".png")
	$Modif/Space.visible = true
	$Modif/AddItem.visible = true
	$Modif/ItemLabel.visible = true
	$Modif/ItemLabel.text = "+"+str(item_bonif)

#func on_item_click(li):
#	var i = li.get_index()
#	var it_name = GC.CURRENT_NODE.bon.keys()[i]
#	li.disabled = true
#	li.modulate.a = .3
#	conc_bonif += GC.CURRENT_NODE.bon[it_name]
#	$Modif/Label2.text = "+"+str(conc_bonif)
#	$Tween.interpolate_property($Modif,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
#	$Tween.start()
