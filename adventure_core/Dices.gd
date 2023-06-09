extends Control

var ability_name = "SIGILO"
var dices_data = null
var ability_bonif = 0
var start_dices_y = 0
var dice_cost = 0
var d1
var d2
var isRolled = false

onready var DicesResults = get_node("../DicesResults")

signal on_dice(value)

func _ready():
	GC.DICES = self
	randomize()
	visible = false
	$Timer.connect("timeout",self,"on_time_dices_update")
	$Buttons/btn_roll.connect("button_down",self,"onButtonRoll")
	$Buttons/btn_back.connect("button_down",self,"onButtonClose")
	$btn_add.connect("button_down",self,"onButtonAdd")
	$DiceCost/btn_cost.connect("button_down",self,"onButtonCost")

func on_time_dices_update():
	d1 = randi()%6+1
	$Dice1.frame = d1-1
	d2 = randi()%6+1
	$Dice2.frame = d2-1

func show_dices(data):
	dices_data = data
	$DiceCost.visible = (GC.CURRENT_NODE && GC.CURRENT_NODE.isDice == 2)
	$ItemSelector.hide_menu()
	$Node_text.text = GC.CURRENT_NODE.text
	if "abName" in dices_data: ability_name = dices_data.abName
	ability_bonif = 0
	dice_cost = 0
	set_usable_items()
	
	$btn_add/Label2.text = str(GC.ACTION_POINTS)
	$lb_ability.text = ability_name+" +"+str(ability_bonif)
	visible = true
	isRolled = false
	$Dice1.visible = false
	$Dice2.visible = false
	$lb_result.visible = false
	$Buttons/btn_roll.visible = true
	$Buttons/btn_back.visible = true
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func onButtonRoll():
	run_dices()

func onButtonClose():
	GC.ACTION_POINTS += ability_bonif + dice_cost
	visible = false

func onButtonAdd():
	if GC.ACTION_POINTS <= 0 || isRolled || ability_bonif>=5: return
	GC.ACTION_POINTS -= 1
	ability_bonif += 1
	$btn_add/Label2.text = str(GC.ACTION_POINTS)
	$lb_ability.text = ability_name+" +"+str(ability_bonif)
	$Tween.interpolate_property($lb_ability,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
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

func run_dices():
	if isRolled: return
	isRolled = true
	check_dices_type()
	$Buttons/btn_roll.visible = false
	$Buttons/btn_back.visible = false
	var duration = 1.2
	$Timer.start()
	$Tween.remove_all()
	var start_pos = Vector2(rect_size.x*.3,rect_size.y*1.2)
	var end_pos = Vector2(rect_size.x*.4,rect_size.y*.7)
	$Tween.interpolate_property($Dice1,"position",start_pos,end_pos,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	var rot = -40-randi()%100
	$Tween.interpolate_property($Dice1,"rotation_degrees",rot,0,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	start_pos = Vector2(rect_size.x*.7,rect_size.y*1.2)
	end_pos = Vector2(rect_size.x*.6,rect_size.y*.7)
	$Tween.interpolate_property($Dice2,"position",start_pos,end_pos,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	rot = -190-randi()%400
	$Tween.interpolate_property($Dice2,"rotation_degrees",rot,0,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	$Tween.start()
	$Dice1.visible = true
	$Dice2.visible = true
	yield(get_tree().create_timer(1),"timeout")
	$Timer.stop()
	yield(get_tree().create_timer(1),"timeout")
	$lb_result.text = str(d1+d2+ability_bonif)
	$lb_result.visible = true
	$lb_result.modulate = Color(0,0,0,.2)
	$Tween.interpolate_property($lb_result,"modulate",$lb_result.modulate,Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	
	yield(get_tree().create_timer(2.2),"timeout")
	visible = false
	emit_signal("on_dice",d1+d2+ability_bonif)
	DicesResults.show_results(d1+d2+ability_bonif,dices_data)

func check_dices_type():
	if(GC.CURRENT_NODE): 
		if GC.CURRENT_NODE.isDice == 1: 
			GC.CURRENT_NODE.isDice = 2
		elif GC.CURRENT_NODE.isDice == 3: 
			GC.DESITIONS.hide_a_showed_desition(GC.CURRENT_NODE.node_id)
		GC.DESITIONS.update_data(false)

func set_usable_items():
	for li in $Items/VBox.get_children(): 
		li.visible = false
		li.disabled = false
		li.modulate.a = 1
		li.connect("button_down",self,"on_item_click",[li])
		
	
	print("BONOS ",GC.CURRENT_NODE)
	if !GC.CURRENT_NODE: return
	if GC.CURRENT_NODE.has("bon"):
		for i in range( GC.CURRENT_NODE.bon.keys().size() ):
			var li = $Items/VBox.get_children()[i]
			var it_name = GC.CURRENT_NODE.bon.keys()[i]
			if GC.get_item(it_name):
				var data = GC.get_item(it_name)
				li.text = "Usar "+data.name+" +"+str(GC.CURRENT_NODE.bon[it_name])
				li.visible = true

func on_item_click(li):
	var i = li.get_index()
	var it_name = GC.CURRENT_NODE.bon.keys()[i]
	li.disabled = true
	li.modulate.a = .3
	ability_bonif += GC.CURRENT_NODE.bon[it_name]
	$lb_ability.text = ability_name+" +"+str(ability_bonif)
	$Tween.interpolate_property($lb_ability,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
