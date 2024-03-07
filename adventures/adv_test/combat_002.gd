extends Node

var texture_image = preload("res://adventures/adv_test/imgs/combat_002_troll.png")
var actions = {
	"n1":{ "text":"Dar un golpe directo", "isDice": 1 },
	"n2":{ "text":"Posicionarte mejor (pierdes el turno pero obtienes ataque)" },
	"n3":{ "text":"Dar un super ataque (dos tiradas pero pierdes ataque)", "isDice": 1 },
	"n4":{ "text":"Atacar a la bestia", "isDice": 1 },
	"n5":{ "text":"Desenfundar mi espada (pierdes el turno pero obtienes mucho ataque)", "isHidden": true },
}

var win_room = "end_004"
var lose_room = "end_003"

# Called when the node enters the scene tree for the first time.
func init_combat_data():
	print("CURRENT COMBAT ID SCRIPTING ",GC.CURRENT_COMBAT_ID);
	get_node("../Enemy/Image").texture = texture_image
	get_parent().pj_bo = 2
	get_parent().pj_ca = 8
	get_parent().pj_res = 0
	get_parent().en_bo = 2
	get_parent().en_ca = 8
	get_parent().en_res = .5
	get_parent().on_finish_script_load()
#	GC.ALL_ITEMS = {"sword":"x","meat":"x","torch":"x"}
#	GC.add_item("sword")
#	GC.add_item("meat")
#	GC.add_item("torch")
	if GC.get_item("sword"): actions["n5"].isHidden = false
	if GC.get_item("meat"): actions["n6"].isHidden = false
	if GC.get_gamevar("furtive_hyena"): get_parent().add_enemy_hp(-40)

func on_click_node(btn,node_id):
	print("CLICK ", node_id)
	if node_id=="n1" || node_id=="n4":
		get_parent().run_dices("PLAYER")
		yield(get_parent(),"end_run_dices")
		get_parent().apply_result("ENEMY")
		yield(get_parent(),"end_apply_result")
		get_parent().end_player_turn()
		
	elif node_id=="n2": #posicionarse
		actions["n2"]["isHidden"] = true
		actions["n3"]["isHidden"] = false
		get_parent().add_player_stat("BO",1)
		yield(get_parent(),"end_add_stat")
		get_parent().end_player_turn()
		
	elif node_id=="n3":
		actions["n3"]["isHidden"] = true
		actions["n2"]["isHidden"] = false
		
		get_parent().run_dices("PLAYER")
		yield(get_parent(),"end_run_dices")
		get_parent().apply_result("ENEMY")
		yield(get_parent(),"end_apply_result")
		
		get_parent().run_dices("PLAYER")
		yield(get_parent(),"end_run_dices")
		get_parent().apply_result("ENEMY")
		yield(get_parent(),"end_apply_result")
		
		get_parent().add_player_stat("BO",-1)
		yield(get_parent(),"end_add_stat")
		
		get_parent().end_player_turn()
		
	elif node_id=="n5": #espada
		actions["n5"]["isHidden"] = true
		get_parent().add_player_stat("BO",2)
		yield(get_parent(),"end_add_stat")
		get_parent().end_player_turn()

func on_end_player_turn():
	#This func is called when end the player turn, if return true, break the end_player_turn func flow
	var en_hp = get_node("../Enemy/HP_ENEM").value
	if en_hp < 60:
		GC.CURRENT_ROOM = win_room
		get_tree().change_scene("res://adventure_core/Adventure.tscn")
		return true
	else: return false
