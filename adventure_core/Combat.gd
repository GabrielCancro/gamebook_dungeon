extends Control

var isRolled = false
var d1 = 0
var d2 = 0
var pj_bo = 2
var pj_ca = 8
var en_bo = 1
var en_ca = 8
var final_dice = 0

signal end_run_dices
signal end_apply_result

var actions = {
	"n1":{ "text":"Propinar un golpe directo", "isDice": 1 },
	"n2":{ "text":"Posicionarse para sacar ventaja" },
	"n3":{ "text":"Intentar un super ataque destructor", "isDice": 1 },
}

func _ready():
	$Timer.connect("timeout",self,"on_time_dices_update")
	$Middle/Dice1.modulate.a = 0
	$Middle/Dice2.modulate.a = 0
	$Middle/Label.modulate.a = 0
	
	set_turn_line("PLAYER")
	set_stats()
	show_actions()
	print(GC.CURRENT_COMBAT_DATA)
	
	$Player/Options.visible = false
	$Tween.interpolate_property($Player/HP_PLAYER,"value",0,100,1,Tween.TRANS_LINEAR,Tween.EASE_OUT,.5)
	$Tween.interpolate_property($Enemy/HP_ENEM,"value",0,100,1,Tween.TRANS_LINEAR,Tween.EASE_OUT,.5)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$Player/Options.visible = true

	

func set_stats():
	$Enemy/Atk/Label.text = "+"+str(en_bo)
	$Enemy/Def/Label.text = str(en_ca)
	$Player/Atk/Label.text = "+"+str(pj_bo)
	$Player/Def/Label.text = str(pj_ca)

func show_actions():
	for desc in $Player/Options.get_children():
		desc.set_node_data(actions["n"+str(desc.get_index()+1) ])
		desc.visible = true
		desc.connect("on_click",self,"run_turn")

func run_turn(arg):
	run_dices("PLAYER")
	yield(self,"end_run_dices")
	apply_result("ENEMY")
	yield(self,"end_apply_result")
	
	yield(get_tree().create_timer(.4),"timeout")	
	set_turn_line("ENEMY")
	yield(get_tree().create_timer(.4),"timeout")
	run_dices("ENEMY")
	yield(self,"end_run_dices")
	apply_result("PLAYER")
	yield(self,"end_apply_result")
	
	yield(get_tree().create_timer(.4),"timeout")
	set_turn_line("PLAYER")
	yield(get_tree().create_timer(.4),"timeout")
	$Player/Options.visible = true

func on_time_dices_update():
	d1 = randi()%6+1
	$Middle/Dice1.frame = d1-1
	d2 = randi()%6+1
	$Middle/Dice2.frame = d2-1

func run_dices(mode):
	if isRolled: return
	isRolled = true
	$Player/Options.visible = false
	var duration = 1.2
	$Timer.start()
	$Tween.remove_all()
	var start_pos = Vector2(rect_size.x*.2,rect_size.y*1.2)
	if mode == "ENEMY": start_pos.y = -rect_size.y*.2
	var end_pos = Vector2(rect_size.x*.35-80,$Middle.rect_size.y*.5+30)
	$Tween.interpolate_property($Middle/Dice1,"position",start_pos,end_pos,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	var rot = -40-randi()%100
	$Tween.interpolate_property($Middle/Dice1,"rotation_degrees",rot,0,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	start_pos = Vector2(rect_size.x*.3,rect_size.y*1.2)
	if mode == "ENEMY": start_pos.y = -rect_size.y*.2
	end_pos = Vector2(rect_size.x*.35+80,$Middle.rect_size.y*.5+30)
	$Tween.interpolate_property($Middle/Dice2,"position",start_pos,end_pos,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	rot = -190-randi()%400
	$Tween.interpolate_property($Middle/Dice2,"rotation_degrees",rot,0,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(.05),"timeout")
	$Middle/Dice1.modulate.a = 1
	$Middle/Dice2.modulate.a = 1
	yield(get_tree().create_timer(1),"timeout")
	$Timer.stop()
	yield(get_tree().create_timer(1),"timeout")
	final_dice = d1+d2+pj_bo
	$Middle/Label.text = str(final_dice)
	var atk_node = $Player/Atk
	if mode == "ENEMY": atk_node = $Enemy/Atk
	$Tween.interpolate_property($Middle/Label,"modulate",$Middle/Label.modulate,Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property(atk_node,"rect_scale",Vector2(1.5,1.5),Vector2(1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	
	yield(get_tree().create_timer(1.2),"timeout")
	isRolled = false
#	visible = false
	emit_signal("end_run_dices")

func apply_result(mode):
	var damage = 25
	var def_node = $Enemy/Def
	var hp_node = $Enemy/HP_ENEM
	var CA = en_ca
	if mode == "PLAYER": 
		def_node = $Player/Def
		hp_node = $Player/HP_PLAYER
		CA = pj_ca
	$Tween.interpolate_property(def_node,"rect_scale",Vector2(1.5,1.5),Vector2(1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(.7),"timeout")
	if final_dice>=CA:
		if mode == "ENEMY": $Tween.interpolate_property($Enemy/Image,"modulate",Color(1,.2,.2,1),Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.interpolate_property(hp_node,"value",hp_node.value,hp_node.value-damage,.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(.8),"timeout")
	$Tween.interpolate_property($Middle/Dice1,"modulate",Color(1,1,1,1),Color(1,1,1,0),.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property($Middle/Dice2,"modulate",Color(1,1,1,1),Color(1,1,1,0),.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property($Middle/Label,"modulate",Color(1,1,1,1),Color(1,1,1,0),.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(.8),"timeout")
	
	if hp_node.value <= 0:
		if mode=="PLAYER": GC.CURRENT_ROOM = GC.CURRENT_COMBAT_DATA.lose_room
		elif mode=="ENEMY": GC.CURRENT_ROOM = GC.CURRENT_COMBAT_DATA.win_room
		get_tree().change_scene("res://adventure_core/Adventure.tscn")
	else: emit_signal("end_apply_result")

func set_turn_line(mode):
	$TurnLine/AnimationPlayer.play("flash")
	$TurnLine.rect_size.y = rect_size.y/2
	var end_pos = $TurnLine.rect_position
	end_pos.y = rect_size.y - $TurnLine.rect_size.y
	if mode == "ENEMY": end_pos.y = 0
	$Tween.interpolate_property($TurnLine,"rect_position",$TurnLine.rect_position,end_pos,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	
