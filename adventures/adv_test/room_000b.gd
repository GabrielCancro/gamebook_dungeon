extends Node

var room_data = {
	"name": "Prologo2",
	"is_auto_next":"room_001",
	"room_id": null,
	"image": null,
	"title": "Un rescate inesperado",
	"desc": """\nYa no queda mucho. El trecho final para la ciudad es el bosque donde te encuentras.
	\nY mientras ves como los pájaros vuelan por sobre los árboles y los venados corren por entre los arbustos del bosque, oyes un grito. Un grito que te hiela la sangre ...
	""",
	"actions": {}
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
