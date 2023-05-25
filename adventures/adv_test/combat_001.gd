extends Node

var actions = {
	"n1":{ "text":"Dar un golpe directo", "isDice": 1 },
	"n2":{ "text":"Posicionarte mejor (pierdes el turno pero obtienes ataque)" },
	"n3":{ "text":"Dar un super ataque (dos tiradas pero pierdes ataque)", "isDice": 1 },
	"n4":{ "text":"Atacar a la bestia", "isDice": 1 },
	"n5":{ "text":"Desenfundar mi espada (pierdes el turno pero obtienes mucho ataque)", "isHidden": true },
	"n6":{ "text":"Utilizar la carne para distraer a la hiena (reduce su defensa)", "isHidden": true },
}

var win_room = "room_007"
var lose_room = "end_001"

# Called when the node enters the scene tree for the first time.
func init_combat_data():
	print("CURRENT COMBAT ID SCRIPTING ",GC.CURRENT_COMBAT_ID);
	get_parent().pj_bo = 2
	get_parent().pj_ca = 8
	get_parent().en_bo = 2
	get_parent().en_ca = 8
	get_parent().on_finish_script_load()
#	GC.ALL_ITEMS = {"sword":"x","meat":"x","torch":"x"}
#	GC.add_item("sword")
#	GC.add_item("meat")
#	GC.add_item("torch")
	if GC.get_item("sword"): actions["n5"].isHidden = false
	if GC.get_item("meat"): actions["n6"].isHidden = false
	if GC.set_gamevar("furtive_hyena"): get_parent().add_enemy_hp(-40)

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
	
	elif node_id=="n6": #carne
		actions["n6"]["isHidden"] = true
		GC.remove_item("meat")
		get_parent().add_enemy_stat("CA",-1)
		yield(get_parent(),"end_add_stat")
		get_parent().end_player_turn()
