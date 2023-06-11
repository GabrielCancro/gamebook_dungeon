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
		"p1":"Es un pequeño fuego que alumbra el lugar. Revisando, encuentras un tronco con un extremo aún sin consumir"
	},
	"dices_buscar":{
		"abName":"Buscar",
		"results":{
			"r0":{"ran":[-99,4],"tx":"Hay cientos de huesos, no creo que sirvan para mucho"},
			"r1":{"ran":[5,99],"tx":"Entre tantos huesos roídos encuentras un trozo de carne en dudoso estado","addItem":"meat"}
		}
	}

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.POPUP.show_popup(room_data.pops.p1,"torch")
		GC.DESITIONS.set_visible_desition("n1",false)
	elif node_id=="n2": 
		GC.DICES.show_dices(room_data.dices_buscar)
	elif node_id=="n3": #a bifurcacion
		GC.ADVENTURE.change_room('room_005')
	elif node_id=="n4": # volver a la entrada
		GC.ADVENTURE.change_room('room_003')

func on_dices_result(res):
	if res.id=="r1":
		GC.DESITIONS.set_visible_desition("n2",false)
