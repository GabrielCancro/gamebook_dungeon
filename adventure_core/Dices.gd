extends Control

var ability_name = "SIGILO"
var ability_bonif = 2
var dificult = 10
var start_dices_y = 0
var d1
var d2

func _ready():
	GC.DICES = self
	randomize()
	visible = false
	$Timer.connect("timeout",self,"on_time_dices_update")
	for btn in $Panel/Buttons.get_children():
		btn.connect("button_down",self,"on_btn_click",[btn.name])

func on_time_dices_update():
	d1 = randi()%6+1
	$Dice1.frame = d1-1
	d2 = randi()%6+1
	$Dice2.frame = d2-1

func show_dices(ab_name,dif,ab_bon):
	ability_name = ab_name
	dificult = dif
	ability_bonif = ab_bon
	show_buttons("start")
	$Panel/lb_ability.text = ability_name
	$Panel/lb_dificult.text = str(dificult)
	$Panel/lb_result.text = "[?]+[?]+"+str(ability_bonif)+" = ??"
	visible = true
	$Dice1.visible = false
	$Dice2.visible = false
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func on_btn_click(name):
	show_buttons("none")
	if name=="btn_roll": run_dices()
	if name=="btn_back": close_dices()
	if name=="btn_success": close_dices()
	if name=="btn_fail": close_dices()
	if name=="btn_reroll": run_dices()
	
func run_dices():
	var duration = 1.2
	$Timer.start()
	$Panel/lb_result.text = "[?]+[?]+"+str(ability_bonif)+" = ??"
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
	yield($Tween,"tween_all_completed")
	$Timer.stop()
	$Panel/lb_result.text = "["+str(d1)+"]+["+str(d2)+"]+"+str(ability_bonif)+" = "+str(d1+d2+ability_bonif)
	yield(get_tree().create_timer(1),"timeout")
	if d1+d1+ability_bonif >= dificult: show_buttons("success")
	else: show_buttons("fail")

func show_buttons(id):
	for btn in $Panel/Buttons.get_children():
		btn.visible = false
	if id=="start":
		$Panel/Buttons/btn_roll.visible = true
		$Panel/Buttons/btn_back.visible = true
	if id=="success":
		$Panel/Buttons/btn_success.visible = true
	if id=="fail":
		$Panel/Buttons/btn_reroll.visible = true
		$Panel/Buttons/btn_fail.visible = true

func close_dices():
	visible = false
