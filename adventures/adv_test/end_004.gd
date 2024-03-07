extends Node

var room_data = {
	"name": "HeroeGana",
	"image": null,
	"desc": """
		Buen Guerrero\n\n
		En un golpe de suerte haces tambalear al troll y logras derribarlo, y sin perder el tiempo pasan sobre y corren a la salida.
		
		- Vuelvan aquiii!! - Grita el troll mientras se reincorpora.
		
		Por suerte logran alcanzar la salida a tiempo y huyen de la cueva. El principe esta a salvo!
		
		La infinita gratitud del principe y algunas monedas son una buena recompenza para tu primer aventura!
		
	""",
	"actions": {
		"n1":{ "text":"FINAL FELIZ" },
	},
	"pops":{
	},
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.end_game()

func on_enter_room():
	pass
