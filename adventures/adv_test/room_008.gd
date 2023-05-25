extends Node

var room_data = {
	"name": "JaulaVacia",
	"image": null,
	"desc": """
		La habitacion es espaciosa, en una de las jaulas se escucha un sollozo, al prestar atencion ves a un joven, por sus vestimentas es el principe, es un alivio que siga con vida.
	""",
	"actions": {
		"n1":{ "text":"Jaula del príncipe" },
		"n2":{ "text":"Buscar en las celdas (Agujero Escondido)" },
		"n3":{ "text":"Restos de la hiena" },
	},
	"pops":{
	},
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();

func on_enter_room():
	pass
