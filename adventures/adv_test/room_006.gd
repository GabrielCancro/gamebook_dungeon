extends Node

var room_data = {
	"name": "Jaulas",
	"image": null,
	"desc": """
		Entras a una gran sala rocosa. 
		Huecos en las paredes parecen celdas de prisión cubiertas con troncos de varios tamaños a modo de puertas. 
		La criatura parece almacenar a sus presas vivas. Puede verse movimiento en una de ellas. 
		Más cerca tuyo, y sin pasar desapercibido, se encuentra el guardián. Una hiena enorme. 
		No podré revisar las jaulas hasta deshacerme de ella.
	""",
	"actions": {
		"n1":{ "text":"Tu llamativa entrada en escena alerta a la hiena, y se ve decidida a devorarte!", "isHidden": true },
		"n2":{ "text":"La hiena aún no te a visto, podría retirarme y volver mas tarde", "isHidden": true },
		"n3":{ "text":"Quizas pueda sorprenderla con un ataque furtivo y sacar ventaja, aunque parece difícil", "isHidden": true, "isDice":3 },
	},
	"pops":{
		"furtive1":"Mientras te acerca para tomar ventaja la hiena escucha tus pasos, preparate para el combate!",
		"furtive2":"Eres tan sigiloso como nunca, te abalanzas sobre ella y la sorprendes con un fuerte golpe en la cabeza, el resto parece fácil",
	},
	"dices_furtivo":{
		"abName":"Furtivo",
		"results":{
			"r0":{"ran":[-99,4],"tx":"Mientras te acerca para tomar ventaja la hiena escucha tus pasos, preparate para el combate!"},
			"r1":{"ran":[5,99],"tx":"Eres tan sigiloso como nunca, te abalanzas sobre ella y la sorprendes con un fuerte golpe en la cabeza, el resto parece fácil.","setGamevar":"furtive_hyena"}
		}
	},

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.start_combat("combat_001") 
	elif node_id=="n2": 
		GC.ADVENTURE.change_room('room_004')
	elif node_id=="n3": 
		GC.DICES.show_dices(room_data.dices_furtivo)
		yield(GC.DICESRESULTS,"end_results")
		GC.start_combat("combat_001")

func on_enter_room():
	if !GC.get_gamevar("stealth_hyena"):
		GC.DESITIONS.set_visible_desition("n1",true)
	else:
		GC.DESITIONS.set_visible_desition("n2",true)
		GC.DESITIONS.set_visible_desition("n3",true)
