extends Node

var room_data = {
	"name": "Comedor",
	"image": null,
	"desc": """Buscas algo que te indique a que sala entrar, pero solo logras imaginarte cosas horrendas.
	Por donde continuaré avanzando?
	""",
	"actions": {
		"n1":{ "text":"Avanzar por la primera sala" },
		"n2":{ "text":"Avanzar por la segunda sala" },
		"n3":{ "text":"No estoy seguro, aún no avanzaré" },
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
	elif node_id=="n2": 
		GC.DICES.show_dices("SETIDOS")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "5":"EP", "8":"EA" } )
		if dices<5:
			yield(GC.POPUP.show_popup(room_data.pops.sentido1), "on_close")
		if dices>=5:
			yield(GC.POPUP.show_popup(room_data.pops.sentido2), "on_close")
			GC.set_gamevar("heardBarking",true)
		if dices>=8:
			yield(GC.POPUP.show_popup(room_data.pops.sentido3), "on_close")
			GC.set_gamevar("heardSnoring",true)
			yield( GC.DESITIONS.hide_a_showed_desition("n2"), "on_finish_difuse")
	elif node_id=="n3": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "5":"E" } )
		if dices<5:
			yield(GC.POPUP.show_popup(room_data.pops.buscar1), "on_close")
		if dices>=5:
			yield(GC.POPUP.show_popup(room_data.pops.buscar2), "on_close")
			GC.add_item("torch")
			yield( GC.DESITIONS.hide_a_showed_desition("n3"), "on_finish_difuse")
	elif node_id=="n4":
		GC.ADVENTURE.change_room('room_005')

func on_enter_room():
	print("ENTER ROOM ",GC.get_current_room_data())
