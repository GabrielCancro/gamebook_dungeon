extends Node

var room_data = {
	"name": "Comedor",
	"image": null,
	"desc": """Con cautela desciendes por el túnel, siguiendo la luz. 
		Al llegar notas la fuente. Una pequeña y rústica fogata ilumina la sala. 
		Sin ningún motivo de decoración, un millar de huesos de todas las especies del bosque se esparcen por el lugar. 
		La sala parece un comedor y conduce a otras dos habitaciones, pero parece peligroso andar sin precaución.
	""",
	"actions": {
		"n1":{ "text":"Tal vez me sirva algo de luz Revisar la fogata" },
		"n2":{ "text":"No se que habrá en las otras salas pero podría ser peligroso. Presentimiento.", "isDice": 3 },
		"n3":{ "text":"Podré encontrar algo en esa pila de huesos? Buscar.", "isDice":1 },
		"n4":{ "text":"Continuar el camino a la siguiente sala", "isHidden":true },
		"n5":{ "text":"Continuar a la siguiente sala, de aquí provienen los ladridos, debo ir con cuidado", "isHidden":true, "isDice":3 },
		"n6":{ "text":"Tal vez sería mejor bajar por el túnel a la otra sala", "isHidden":true },
		"n7":{ "text":"Bajar por el túnel a la otra sala, los ronquidos provenían de aquí, seré silencioso", "isHidden":true, "isDice":3 },
	},
	"pops":{
		"p1":"Un pequeño fuego que alumbra el lugar.\n\n +Nuevo item: ANTORCHA",
		"sentido1":"Intentas escuchar por un buen rato pero no oyes nada. Las salas parecen vacías",
		"sentido2":"Escuchas un ladrido de la primera sala, creo que puede ser el guardián",
		"sentido3":"Pones toda tu atención en la tarea, y pareces escuchar un ronquido que proviene de la segunda sala",
		"buscar1":"Hay cientos de huesos, no creo que sirvan para mucho",
		"buscar2":"Entre tantos huesos roídos encuentras un trozo de carne en dudoso estado.\n\n +Nuevo item: CARNE",
	},
	"items": {
		"torch": {"name":"Antorcha", "img":null, "desc": "Un trozo de madera de la fogata te sirve como antorcha."},
		"meat": {"name":"Carne", "img":null, "desc": "Carne en dudoso estado, va, dudoso.. esta podrida."},
	}
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		yield( GC.POPUP.show_popup(room_data.pops.p1), "on_close")
		GC.add_item("torch") 
		yield( GC.DESITIONS.hide_a_showed_desition("n1"), "on_finish_difuse")
	elif node_id=="n2":
		GC.DICES.show_dices("SENTIDOS")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "5":"EP", "8":"EA" } )
#		GC.set_gamevar("heardDices",res)
		if dices<5:
			yield(GC.POPUP.show_popup(room_data.pops.sentido1), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n4"), "on_finish_resalt" )
			yield( GC.DESITIONS.show_a_hidden_desition("n6"), "on_finish_resalt" )
		elif dices>=5 && dices<8:
			yield(GC.POPUP.show_popup(room_data.pops.sentido2), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n5"), "on_finish_resalt" )
			yield( GC.DESITIONS.show_a_hidden_desition("n6"), "on_finish_resalt" )
		elif dices>=8:
			yield(GC.POPUP.show_popup(room_data.pops.sentido2), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n5"), "on_finish_resalt" )
			yield(GC.POPUP.show_popup(room_data.pops.sentido3), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n7"), "on_finish_resalt" )
	elif node_id=="n3": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "5":"EA" } )
		if dices<5:
			yield(GC.POPUP.show_popup(room_data.pops.buscar1), "on_close")
		if dices>=5:
			yield(GC.POPUP.show_popup(room_data.pops.buscar2), "on_close")
			GC.add_item("meat")
			yield( GC.DESITIONS.hide_a_showed_desition("n3"), "on_finish_difuse")
