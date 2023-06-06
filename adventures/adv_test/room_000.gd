extends Node

var room_data = {
	"name": "Prologo",
	"room_id": null,
	"image": null,
	"title": "Un rescate inesperado",
	"desc": """Un nuevo día de viaje. Los pájaros vuelan por sobre los árboles y los venados corren por entre los arbustos del bosque. El camino está despejado y la mañana parece tranquila.
	\nDe hecho, desde que comenzaste tu viaje, este ha sido muy tranquilo. Llevas ya unos días viajando. Has cruzado algunos pueblos y, fuera de alguna que otra pelea en un bar, nada ha impedido que llegues a tiempo a tu destino: La ciudad de [b]Illenys[/b], capital del reino.
	\nPero ese no es el único atractivo. La gran ciudad es el hogar del gremio de guerreros, donde se entrena para guardia real, puesto al que aspiras desde pequeña.
	\nYa no queda mucho. El trecho final para la ciudad es el bosque donde te encuentras.
	""",
	"actions": {
		"n1":{ "text":"Continuar" },
	}
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_001")
