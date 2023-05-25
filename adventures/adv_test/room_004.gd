extends Node

var room_data = {
	"name": "Comedor",
	"image": null,
	"desc": """
		Con cautela desciendes por el túnel, siguiendo la luz. 
		Al llegar notas la fuente. Una pequeña y rústica fogata ilumina la sala. 
		Sin ningún motivo de decoración, un millar de huesos de todas las especies del bosque se esparcen por el lugar. 
		La sala parece un comedor y conduce a otras dos habitaciones, pero parece peligroso andar sin precaución.
	""",
	"actions": {
		"n1":{ "text":"Tal vez me sirva algo de luz. Revisar la fogata" },
		"n2":{ "text":"Podré encontrar algo en esa pila de huesos? Buscar.", "isDice":1 },
		"n3":{ "text":"Por donde debería continuar?" },
		"n4":{ "text":"Volver a la entrada siempre es una opción" },
	},
	"pops":{
		"p1":"Un pequeño fuego que alumbra el lugar.\n\n +Nuevo item: ANTORCHA",
		"buscar1":"Hay cientos de huesos, no creo que sirvan para mucho",
		"buscar2":"Entre tantos huesos roídos encuentras un trozo de carne en dudoso estado.\n\n +Nuevo item: CARNE",
	},

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		yield( GC.POPUP.show_popup(room_data.pops.p1), "on_close")
		GC.add_item("torch") 
		yield( GC.DESITIONS.hide_a_showed_desition("n1"), "on_finish_difuse")
	elif node_id=="n2": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "5":"EA" } )
		if dices<5:
			yield(GC.POPUP.show_popup(room_data.pops.buscar1), "on_close")
		if dices>=5:
			yield(GC.POPUP.show_popup(room_data.pops.buscar2), "on_close")
			GC.add_item("meat")
			yield( GC.DESITIONS.hide_a_showed_desition("n3"), "on_finish_difuse")
	elif node_id=="n3": #a bifurcacion
		GC.ADVENTURE.change_room('room_005')
	elif node_id=="n4": # volver a la entrada
		GC.ADVENTURE.change_room('room_003')
