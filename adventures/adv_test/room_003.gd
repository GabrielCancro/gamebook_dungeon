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
		"n1":{ "text":"Podría haber algo por aquí? Hay poca luz, será difícil con esta oscuridad", "isDice": 1, "bon":{"torch":4} },
		"n2":{ "text":"Algo de iluminación te conduce hacia otra sala, avanzar hacia allí" },
	},
	"dices_buscar":{
		"abName":"Buscar",
		"item":"torch",
		"results":{
			"r0":{"ran":[-99,7],"tx":"El lugar está muy oscuro, no encuentras nada de interés"},
			"r1":{"ran":[8,99],"tx":"Entre rocas y maleza, algo que brilla llama tu atención","addItem":"lockpick"},
			"r2":{"ran":[10,99],"tx":"Tras hurgar con extrema pericia, encuentras un papel con marcas interesantes","addItem":"map1"},}
	}

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.DICES.show_dices(room_data.dices_buscar)
	elif node_id=="n2": 
		GC.ADVENTURE.change_room('room_004')


func on_dices_result(res):
	if res.id=="r2":
		GC.DESITIONS.set_visible_desition("n1",false)
