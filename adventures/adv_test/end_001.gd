extends Node

var room_data = {
	"name": "HienaGana",
	"image": null,
	"desc": """
		Ni Mataperros \n\n
		Matar a la hiena no parecía tan difícil, sobre todo porque tenía correa. Pero no contabas con que fueras tan malo luchando.
		En un mal movimiento de combate, la hiena se te abalanza atacándote en el cuello y la sangre comienza a brotar sin parar.
		Mientras te desangras puedes ver como el sabueso desgarra tu estómago y devora tus vísceras. Parece ser que solo tenía hambre.
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
