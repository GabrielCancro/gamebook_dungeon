extends Node

var room_data = {
	"name": "Bifurcacion",
	"image": null,
	"desc": """
		Las dos opciones por donde continuar son aterradoras. 
		A la izquierda un corredor humedo lleno de rasguños. 
		A la derecha una leve pendiente hacia abajo dificulta la vista.
	""",
	"actions": {
		"n1":{ "text":"No se que habrá en las otras salas pero podría ser peligroso. Presentimiento.", "isDice": 3 },
		"n2":{ "text":"Continuar por el corredor de la izquierda" },
		"n3":{ "text":"Bajar la pendiente a la derecha" },
		"n4":{ "text":"Continuar por el corredor, de aquí provienen los ladridos, debo ir con cuidado", "isHidden":true, "isDice":3 },
		"n5":{ "text":"Bajar por la pendiente, los ronquidos provenían de aquí, seré silencioso", "isHidden":true, "isDice":3 },
		"n6":{ "text":"No debería continuar aún" },
	},
	"pops":{
		"sentido1":"Intentas escuchar por un buen rato pero no oyes nada. Las salas parecen vacías",
		"sentido2":"Escuchas un ladrido de la primera sala, creo que puede ser el guardián",
		"sentido3":"Pones toda tu atención en la tarea, y pareces escuchar un ronquido que proviene de la segunda sala",
	},

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1":
		GC.DICES.show_dices("SENTIDOS")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "5":"EP", "8":"EA" } )
		if dices<5:
			yield(GC.POPUP.show_popup(room_data.pops.sentido1), "on_close")
		if dices>=5:
			GC.DESITIONS.hide_a_showed_desition("n2")
			yield(GC.POPUP.show_popup(room_data.pops.sentido2), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n4"), "on_finish_resalt" )
		if dices>=8:
			GC.DESITIONS.hide_a_showed_desition("n3")
			yield(GC.POPUP.show_popup(room_data.pops.sentido3), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n5"), "on_finish_resalt" )
	elif node_id=="n2": #jaula sin tirada
		GC.ADVENTURE.change_room('room_006')
	elif node_id=="n3": #troll sin tirada
		pass
	elif node_id=="n4": #jaula con tirada
		GC.DICES.show_dices("SIGILIO")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "5":"EA" } )
		if dices>=5: GC.set_gamevar("stealth_hyena",true)
		GC.DESITIONS.show_a_hidden_desition("n4")
		GC.ADVENTURE.change_room('room_006')
	elif node_id=="n5": #troll con tirada
		pass
	elif node_id=="n6": 
		GC.ADVENTURE.change_room('room_004')
