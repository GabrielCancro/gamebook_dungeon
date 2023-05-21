extends Control

var action_line_scene = preload("res://adventure_core/ActionLine.tscn")

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
signal end_add_stat

func _ready():
	$Timer.connect("timeout",self,"on_time_dices_update")
	$EndButton.connect("button_down",self,"on_click_end_button")
	$Middle/Dice1.modulate.a = 0
	$Middle/Dice2.modulate.a = 0
	$Middle/Label.modulate.a = 0
	$TurnLabel.modulate.a = 0
	$TurnLabel.visible = true
	$Player/DamageLabel.visible = false
	$Enemy/DamageLabel.visible = false
	
	$CS.set_script( load("res://adventures/adv_test/"+GC.CURRENT_COMBAT_ID+".gd") )
	$CS.init_combat_data()

func on_finish_script_load():
	set_turn_line("PLAYER")
	set_stats()
	$Player/Options.visible = false
	$Tween.interpolate_property($Player/HP_PLAYER,"value",0,100,1,Tween.TRANS_LINEAR,Tween.EASE_OUT,.5)
	$Tween.interpolate_property($Enemy/HP_ENEM,"value",0,100,1,Tween.TRANS_LINEAR,Tween.EASE_OUT,.5)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	show_actions()
	
func set_stats():
	$Enemy/Atk/Label.text = "+"+str(en_bo)
	$Enemy/Def/Label.text = str(en_ca)
	$Player/Atk/Label.text = "+"+str(pj_bo)
	$Player/Def/Label.text = str(pj_ca)

func show_turn_label(mode):
	if mode=="PLAYER": $TurnLabel/Label.text = "Tu Turno"
	if mode=="ENEMY": $TurnLabel/Label.text = "Turno Del Enemigo"
	$Tween.interpolate_property($TurnLabel,"modulate",Color(1,1,1,.8),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(.6),"timeout")
	$Tween.interpolate_property($TurnLabel,"modulate",Color(1,1,1,1),Color(1,1,1,0),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	yield(get_tree().create_timer(.4),"timeout")
	$Tween.start()
	
func show_actions():
	show_turn_label("PLAYER")
	yield(get_tree().create_timer(1.2),"timeout")
	$Player/Options.visible = true
	randomize()
	var exclude_nodes = []
	for line in $Player/Options.get_children(): 
		$Player/Options.remove_child(line)
		line.queue_free()
	for i in range(3):
		var node_id = null
		var selected = 0
		while node_id==null:
			node_id = $CS.actions.keys()[ randi()%$CS.actions.keys().size() ]
			if !exclude_nodes.has(node_id) && $CS.actions[node_id].has("isHidden") && $CS.actions[node_id].isHidden: exclude_nodes.append(node_id)
			if exclude_nodes.has(node_id): node_id = null
			if exclude_nodes.size()>=$CS.actions.size(): break
		
		if node_id:
			exclude_nodes.append(node_id)
			var line = action_line_scene.instance()
			line.set_node_data($CS.actions[ node_id ])
			line.connect("on_click",$CS,"on_click_node",[node_id])
			$Player/Options.add_child(line)

func end_player_turn():
	show_turn_label("ENEMY")
	set_turn_line("ENEMY")
	yield(get_tree().create_timer(1.2),"timeout")
	yield(get_tree().create_timer(.4),"timeout")
	run_dices("ENEMY")
	yield(self,"end_run_dices")
	apply_result("PLAYER")
	yield(self,"end_apply_result")
	
	yield(get_tree().create_timer(.4),"timeout")
	set_turn_line("PLAYER")
	yield(get_tree().create_timer(.4),"timeout")
	show_actions()

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
	var BO = pj_bo
	if mode == "ENEMY": BO = en_bo
	final_dice = d1+d2+BO
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
	var def_node = $Enemy/Def
	var hp_node = $Enemy/HP_ENEM
	var dmg_label = $Enemy/DamageLabel
	var CA = en_ca
	if mode == "PLAYER": 
		def_node = $Player/Def
		hp_node = $Player/HP_PLAYER
		dmg_label = $Player/DamageLabel
		CA = pj_ca
	$Tween.interpolate_property(def_node,"rect_scale",Vector2(1.5,1.5),Vector2(1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(.7),"timeout")
	if final_dice>=CA:
		var damage = 20 + max(0,final_dice-CA) * 3
		dmg_label.text = "-"+str(damage)
		dmg_label.visible = true
		if mode == "ENEMY": $Tween.interpolate_property($Enemy/Image,"modulate",Color(1,.2,.2,1),Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.interpolate_property(hp_node,"value",hp_node.value,hp_node.value-damage,.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(.8),"timeout")
		dmg_label.visible = false
	$Tween.interpolate_property($Middle/Dice1,"modulate",Color(1,1,1,1),Color(1,1,1,0),.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property($Middle/Dice2,"modulate",Color(1,1,1,1),Color(1,1,1,0),.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property($Middle/Label,"modulate",Color(1,1,1,1),Color(1,1,1,0),.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(.8),"timeout")
	
	if hp_node.value <= 0: end_combat(mode)		
	else: emit_signal("end_apply_result")

func add_player_stat(stat,cnt):
	var node
	$Player/Options.visible = false
	yield(get_tree().create_timer(.4),"timeout")
	if(stat=="BO"):
		node = $Player/Atk
		pj_bo += cnt
		set_stats()
	if(stat=="CA"):
		node = $Player/Def
		pj_ca += cnt
		set_stats()
	if node:
		$Tween.interpolate_property(node,"rect_scale",Vector2(1.5,1.5),Vector2(1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(.8),"timeout")
	emit_signal("end_add_stat")

func add_enemy_stat(stat,cnt):
	var node
	$Player/Options.visible = false
	yield(get_tree().create_timer(.4),"timeout")
	if(stat=="BO"):
		node = $Enemy/Atk
		en_bo += cnt
		set_stats()
	if(stat=="CA"):
		node = $Enemy/Def
		en_ca += cnt
		set_stats()
	if node:
		$Tween.interpolate_property(node,"rect_scale",Vector2(1.5,1.5),Vector2(1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(.8),"timeout")
	emit_signal("end_add_stat")

func add_enemy_hp(cnt):
	yield($Tween,"tween_all_completed")
	$Tween.interpolate_property($Enemy/HP_ENEM,"value",$Enemy/HP_ENEM.value,$Enemy/HP_ENEM.value+cnt,.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func set_turn_line(mode):
	$TurnLine/AnimationPlayer.play("flash")
	$TurnLine.rect_size.y = rect_size.y/2
	var end_pos = $TurnLine.rect_position
	end_pos.y = rect_size.y - $TurnLine.rect_size.y
	if mode == "ENEMY": end_pos.y = 0
	$Tween.interpolate_property($TurnLine,"rect_position",$TurnLine.rect_position,end_pos,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

func end_combat(mode):
	$EndButton.modulate.a = 0
	$EndButton.disabled = true
	$EndButton.visible = true
	$Tween.interpolate_property($EndButton,"modulate",Color(1,1,1,0),Color(1,1,1,1),.8,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	if mode=="PLAYER": 
		GC.CURRENT_ROOM = $CS.lose_room
		$EndButton/End/Label.text = "Derrotado"
	elif mode=="ENEMY": 
		GC.CURRENT_ROOM = $CS.win_room
		$EndButton/End/Label.text = "Has Ganado"
	yield(get_tree().create_timer(.6),"timeout")
	$EndButton.disabled = false

func on_click_end_button():
	if GC.CURRENT_ROOM: get_tree().change_scene("res://adventure_core/Adventure.tscn")
	else: get_tree().change_scene("res://scenes/Main.tscn")
