extends Node

var room_data = {
	"name": "TrollGana",
	"image": null,
	"desc": """
		La cena\n\n
		La pelea fue larga, pero finarlmete el troll te atrapo entre sus manos, sin mucho que poder hacer eres devorado, en tus ultimos segundos de vida escuchas las palabras del principe:
		
		- Imbécil! debías rescatarme, no morir!! -

	""",
	"actions": {
		"n1":{ "text":"HAS MUERTO" },
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
