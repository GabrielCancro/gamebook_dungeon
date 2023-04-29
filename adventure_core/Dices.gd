extends Control

var ability_name = "SIGILO"
var ability_bonif = 0
var start_dices_y = 0
var d1
var d2
var isRolled = false

signal on_dice(value)

func _ready():
	GC.DICES = self
	randomize()
	visible = false
	$Timer.connect("timeout",self,"on_time_dices_update")
	$Buttons/btn_roll.connect("button_down",self,"onButtonRoll")
	$Buttons/btn_back.connect("button_down",self,"onButtonClose")
	$Buttons/btn_end.connect("button_down",self,"onButtonEnd")
	$btn_add.connect("button_down",self,"onButtonAdd")

func on_time_dices_update():
	d1 = randi()%6+1
	$Dice1.frame = d1-1
	d2 = randi()%6+1
	$Dice2.frame = d2-1

func show_dices(ab_name):
	ability_name = ab_name
	ability_bonif = 0
	$btn_add/Label2.text = str(GC.ACTION_POINTS)
	$lb_ability.text = ability_name+" +"+str(ability_bonif)
	visible = true
	isRolled = false
	$Dice1.visible = false
	$Dice2.visible = false
	$lb_result.visible = false
	$Buttons/btn_roll.visible = true
	$Buttons/btn_back.visible = true
	$Buttons/btn_end.visible = false
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func onButtonRoll():
	run_dices()

func onButtonClose():
	GC.ACTION_POINTS += ability_bonif
	visible = false

func onButtonEnd():
	visible = false
	emit_signal("on_dice",d1+d2+ability_bonif)

func onButtonAdd():
	if GC.ACTION_POINTS <= 0 || isRolled: return
	GC.ACTION_POINTS -= 1
	ability_bonif += 1
	$btn_add/Label2.text = str(GC.ACTION_POINTS)
	$lb_ability.text = ability_name+" +"+str(ability_bonif)
	$Tween.interpolate_property($lb_ability,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func run_dices():
	isRolled = true
	$Buttons/btn_roll.visible = false
	$Buttons/btn_back.visible = false
	var duration = 1.2
	$Timer.start()
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
	$Tween.interpolate_property($lb_result,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	$Buttons/btn_end.visible = true
