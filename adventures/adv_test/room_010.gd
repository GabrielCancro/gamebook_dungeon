extends Node

var room_data = {
	"name": "TrollRoom",
	"image": null,
	"desc": """
		Tras descender lentamente por las escaleras del túnel, te encuentras frente a la criatura. Un enorme troll de caverna descansa profundamente sobre un colchón de paja. 
		No parece que despertará enseguida, pero es mejor mantener silencio como precaución. 
		
		Al otro lado de la habitación, hay un cofre ligeramente dañado, pero asegurado con un candado gigantesco. Golpearlo sería fácil pero arriesgado debido al troll. 
		Sin embargo, forzar el candado es más seguro aunque más desafiante. 
	""",
	"actions": {
		"n1":{ "text":"Con paciencia y tus ganzuas puedes intentar abrir el candado del cofre", "isDice": 1, "isHidden": true },
		"n2":{ "text":"Puedes golpear el cofre con violencia hasta abrirlo, la sutileza no es para ti", "isDice": 1 },
		"n3":{ "text":"El cofre por fin esta abierto, ya puedes revisar su contenido", "isHidden": true },
		"n4":{ "text":"Nunca habias visto un troll tan de cerca, es exitante, algo te tienta a picarlo con un palito para ver como se queja" },
		"n5":{ "text":"Volver a picar al troll, la tentación es cada vez mayor", "isHidden": true  },
		"n6":{ "text":"Quezas si solo lo picara una vez mas...", "isHidden": true  }
	},
	"pops":{
		"p1":"Picas al troll, pero este no parece darse cuenta, ni siquiera se molesta.",
		"p2":"Vuelves a picar al trol y esta vez notas un cambio en su ronquido, una leve queja, pero aun no se mueve.",
		"p3":"El viejo cofre, ya abierto, contenía algunas cosas de valor."
	},
	"dices_abrir_lockpick":{
		"abName":"Abrir",
		"item":"lockpick",
		"results":{
			"r0":{"ran":[-99,9],"tx":"Por más que te esfuerzas no logras abrir el cofre."},
			"r1":{"ran":[10,99],"tx":"Tras insistir por un tiempo el candado se abre.","newDesition":"n3"}
		}
	},
	"dices_forzar":{
		"abName":"Forzar",
		"results":{
			"f0":{"ran":[-99,4],"tx":"Si quieres abrir el cofre debes golpearlo más fuerte."},
			"f1":{"ran":[5,8],"tx":"El golpe justo no existe en esta situación, y te das cuenta de ello al escuchar un bufido detrás de tí.","newDesition":"n3"},
			"f2":{"ran":[9,99],"tx":"El golpe justo de fuerza es una recompensa en sí, el cofre se abre y el troll sigue durmiendo.","newDesition":"n3"}
		}
	},

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.DICES.show_dices(room_data.dices_forzar)
#		yield(GC.DICESRESULTS,"end_results")
#		GC.start_combat("combat_001")
	elif node_id=="n2": 
		GC.DICES.show_dices(room_data.dices_abrir)
	elif node_id=="n3": 
		GC.POPUP.show_popup(room_data.pops.p1,"map2")
	elif node_id=="n4": 
		GC.POPUP.show_popup(room_data.pops.p1)
		GC.DESITIONS.set_visible_desition("n4",false)
		GC.DESITIONS.set_visible_desition("n5",true)
	elif node_id=="n5": 
		GC.POPUP.show_popup(room_data.pops.p2)
		GC.DESITIONS.set_visible_desition("n5",false)
		GC.DESITIONS.set_visible_desition("n6",true)
	elif node_id=="n6": 
		GC.ADVENTURE.change_room('end_002')

func on_enter_room():
	pass
	if (GC.get_item("lockpick")): 
		GC.DESITIONS.set_visible_desition("n1",true)
#	if !GC.get_gamevar("stealth_troll"):
#		GC.DESITIONS.set_visible_desition("n1",true)
#	else:
#		GC.DESITIONS.set_visible_desition("n2",true)
#		GC.DESITIONS.set_visible_desition("n3",true)
