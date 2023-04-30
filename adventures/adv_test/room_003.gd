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
		"n1":{ "text":"Podría haber algo por aquí? Hay poca luz, será difícil con esta oscuridad" },
		"n2":{ "text":"Algo de iluminación te conduce hacia otra sala, avanzar hacia allí" },
	}
}

func on_click_node(data,node_id):
	print("CLICK IN",data)
	if node_id=="n1": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "8":"EP", "10":"EA" } )
		if dices<8:
			yield( GC.POPUP.show_popup("El lugar está muy oscuro, no encuentras nada de interés",false), "on_close")
		if dices>=8:
			yield( GC.POPUP.show_popup("Entre rocas y maleza, algo que brilla llama tu atención.\n\n +Nuevo item: GANZÚA",false), "on_close")
			GC.ADV_DATA.items["lockpick"] = {"name":"Ganzúa", "img":null, "desc": "Una precaria y corroida ganzúa metalica, podría servir para alguna cerradura estropeada."}
		if dices>=10:
			yield( GC.POPUP.show_popup("Tras hurgar con extrema pericia, encuentras un papel con marcas interesantes.\n\n +Nuevo item: TROZO DE MAPA",false), "on_close")
			GC.ADV_DATA.items["map1"] = {"name":"Trozo de mapa", "img":null, "desc": "Es un trozo de lo que parece el mapa de algún lugar o tesoro, solo tenemos la mitad de él"}
			yield( GC.DESITIONS.hide_a_showed_desition("n1"), "on_finish_difuse")
		GC.POPUP.set_dice_result(null)
	elif node_id=="n2": 
		yield( GC.POPUP.show_popup("Hasta acá llegué! \n\n pronto habrá mas contenido...",false), "on_close")
#		get_tree().change_scene("res://scenes/Main.tscn")
