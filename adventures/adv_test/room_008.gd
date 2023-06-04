extends Node

var room_data = {
	"name": "JaulaVacia",
	"image": null,
	"desc": """
		La mayoría de las jaulas contienen huesos roídos, tal vez por la hiena o las ratas. 
		Poco a poco te acercas a donde habías visto movimiento. 
		Un joven de buen vestir, algo golpeado, yace acurrucado en el suelo. 
		Es el príncipe. Entre lloros te explica la situación que ya sabes y pide que lo rescates.
	""",
	"actions": {
		"n1":{ "text":"Abrir la Jaula del príncipe" },
	},
	"pops":{
	},
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_009") 
	elif node_id=="n2": 
		GC.ADVENTURE.change_room("room_005")

func on_enter_room():
	pass
