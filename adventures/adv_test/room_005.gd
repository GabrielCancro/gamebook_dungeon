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
		"n3":{ "text":"Continuar por el corredor, de aquí provienen los ladridos, debo ir con cuidado", "isHidden":true, "isDice":4 },
		"n4":{ "text":"Bajar la pendiente a la derecha" },
		"n5":{ "text":"Bajar por la pendiente, los ronquidos provenían de aquí, seré silencioso", "isHidden":true, "isDice":4 },
		"n6":{ "text":"No debería continuar aún" },
	},
	"dices_sentir":{
		"abName":"Sentir",
		"results":{
			"r0":{"ran":[-99,4],"tx":"Intentas escuchar por un buen rato pero no oyes nada. Las salas parecen vacías."},
			"r1":{"ran":[5,99],"tx":"Escuchas un ladrido de la primera sala, creo que puede ser el guardián.","newDesition":"n3"},
			"r2":{"ran":[8,99],"tx":"Pones toda tu atención en la tarea, y pareces escuchar un ronquido que proviene de la segunda sala.","newDesition":"n5"}
		}
	},
	"dices_sigilio_jaulas":{
		"abName":"Sigilio",
		"results":{
			"s0":{"ran":[-99,4],"tx":"Intentas ser cauteloso, pero los nervios te juegan una mala pasada, tropiezas y entras a la sala casi gritando por miedo a golpearte el rostro."},
			"s1":{"ran":[5,99],"tx":"Avanzas hasta la siguiente habitacion tan silencioso como puedes.","setGamevar":"stealth_hyena"}
		}
	},
	"dices_sigilio_troll":{
		"abName":"Sigilio",
		"results":{
			"t0":{"ran":[-99,4],"tx":"Intentas descender con cuidado pero resbalas, bajas la escalinata golpeando en cada escalón."},
			"t1":{"ran":[5,99],"tx":"Desciendes cautelosamente por una escalinata, se escuchan ronquidos cada vez mas fuertes.","setGamevar":"stealth_troll"}
		}
	}

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1":
		GC.DICES.show_dices(room_data.dices_sentir)
	elif node_id=="n2": #jaula sin tirada
		GC.ADVENTURE.change_room('room_006')
	elif node_id=="n3": #jaula con tirada
		GC.DICES.show_dices(room_data.dices_sigilio_jaulas)
		yield(GC.DICESRESULTS,"end_results")
		GC.ADVENTURE.change_room('room_006')
	elif node_id=="n4": #troll sin tirada
		GC.ADVENTURE.change_room('room_010')
	elif node_id=="n5": #troll con tirada
		GC.DICES.show_dices(room_data.dices_sigilio_troll)
		yield(GC.DICESRESULTS,"end_results")
		GC.ADVENTURE.change_room('room_010')
	elif node_id=="n6": 
		GC.ADVENTURE.change_room('room_004')

func on_dices_result(res):
	if res.id=="r1": GC.DESITIONS.set_visible_desition("n2",false)
	if res.id=="r2": GC.DESITIONS.set_visible_desition("n4",false)
