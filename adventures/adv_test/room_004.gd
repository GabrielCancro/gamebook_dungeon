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
		"n1":{ "text":"Tal vez me sirva algo de luz Revisar la fogata" },
		"n2":{ "text":"No se que habrá en las otras salas pero podría ser peligroso. Presentimiento." },
		"n3":{ "text":"La cantidad y variedad de huesos en este lugar indica que la bestia no discrimina. Pero es obvio que es carnívora. Podré encontrar algo en esa pila de huesos? Buscar." },
		
		
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
	return
	if node_id=="n1": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "8":"EP", "10":"EA" } )
		if dices<8:
			yield( GC.POPUP.show_popup("El lugar está muy oscuro, no encuentras nada de interés"), "on_close")
		if dices>=8:
			yield( GC.POPUP.show_popup("Entre rocas y maleza, algo que brilla llama tu atención.\n\n +Nuevo item: GANZÚA"), "on_close")
			GC.ADV_DATA.items["lockpick"] = {"name":"Ganzúa", "img":null, "desc": "Una precaria y corroida ganzúa metalica, podría servir para alguna cerradura estropeada."}
		if dices>=10:
			yield( GC.POPUP.show_popup("Tras hurgar con extrema pericia, encuentras un papel con marcas interesantes.\n\n +Nuevo item: TROZO DE MAPA"), "on_close")
			GC.ADV_DATA.items["map1"] = {"name":"Trozo de mapa", "img":null, "desc": "Es un trozo de lo que parece el mapa de algún lugar o tesoro, solo tenemos la mitad de él"}
			yield( GC.DESITIONS.hide_a_showed_desition("n1"), "on_finish_difuse")
		GC.POPUP.set_dice_result(null)
	elif node_id=="n2": 
		yield( GC.POPUP.show_popup("Hasta acá llegué! \n\n pronto habrá mas contenido..."), "on_close")
#		get_tree().change_scene("res://scenes/Main.tscn")
