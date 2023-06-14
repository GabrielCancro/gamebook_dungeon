extends Node

var room_data = {
	"name": "HienaGana",
	"image": null,
	"desc": """
		El insistente \n\nDespués de molestar al Troll con el palito varias veces, empieza a quejarse y moverse de un lado a otro, es una criatura horrenda. Sientes un susurro provenir de sus fauces.
		
		- Que bueno que viniste... -
		
		El Troll despierta. Te observa un momento y se abalanza contra ti despedazandote en el acto.
		
		Mientras crujen tus huesos te das cuenta que no es buena idea despertar a un troll de su siesta.

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
