extends Node

var room_data = {
	"name": "Guardia Herido",
	"image": null,
	"desc": """
		La entrada es amplia, bastante grande. 
		Varías rocas apiladas sirven de escalera para bajar. 
		Ya dentro, el ambiente es húmedo. Y, a pesar de la gran entrada, la oscuridad es intensa. 
		Al fondo, sin embargo, puede verse un pasillo del cual proviene una tenue luz.
	""",
	"actions": {
		"n1":{ "text":"Podría haber algo por aquí? Hay poca luz, será difícil con esta oscuridad", "isDice": 1 },
		"n2":{ "text":"Algo de iluminación te conduce hacia otra sala, avanzar hacia allí" },
	},
	"pops":{
		"r1":"El lugar está muy oscuro, no encuentras nada de interés",
		"r2":"Entre rocas y maleza, algo que brilla llama tu atención.\n\n +Nuevo item: GANZÚA",
		"r3":"Tras hurgar con extrema pericia, encuentras un papel con marcas interesantes.\n\n +Nuevo item: TROZO DE MAPA"
	},

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "8":"EP", "10":"EA" } )
		if dices<8:
			yield( GC.POPUP.show_popup(room_data.pops.r1), "on_close")
		if dices>=8:
			yield( GC.POPUP.show_popup(room_data.pops.r2), "on_close")
			GC.add_item("lockpick") 
		if dices>=10:
			yield( GC.POPUP.show_popup(room_data.pops.r3), "on_close")
			GC.add_item("map1") 
			yield( GC.DESITIONS.hide_a_showed_desition("n1"), "on_finish_difuse")
		GC.POPUP.set_dice_result(null)
	elif node_id=="n2": 
		GC.ADVENTURE.change_room('room_004')
