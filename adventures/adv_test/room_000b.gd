extends Node

var room_data = {
	"name": "Prologo",
	"room_id": null,
	"image": null,
	"desc": """
		Ya no queda mucho. El trecho final para la ciudad es el bosque donde te encuentras.
		Y mientras ves como los pájaros vuelan por sobre los árboles y los venados corren por entre los arbustos del bosque, oyes un grito.
		Un grito que te hiela la sangre.
	""",
	"actions": {
		"n1":{ "text":"Correr hacia donde escuchas el grito." },
	}
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_001")
