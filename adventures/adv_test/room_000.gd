extends Node

var room_data = {
	"name": "Prologo",
	"room_id": null,
	"image": null,
	"desc": """
		Un nuevo día de viaje. Los pájaros vuelan por sobre los árboles y los venados corren por entre los arbustos del bosque. 
		El camino está despejado y la mañana parece tranquila.
		De hecho, desde que comenzaste tu viaje, este ha sido muy tranquilo. 
		Llevas ya unos días viajando. Has cruzado algunos pueblos y, fuera de alguna que otra pelea en un bar, nada ha impedido que llegues a tiempo a tu destino: La ciudad de Illenys, capital del reino.
		Pero ese no es el único atractivo. La gran ciudad es el hogar del gremio de guerreros, donde se entrena para guardia real, puesto al que aspiras desde pequeña.
	""",
	"actions": {
		"n1":{ "text":"Continuar el camino, ya no falta tanto." },
	}
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_000b")
