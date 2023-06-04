extends Node

var room_data = {
	"name": "JaulaVacia",
	"image": null,
	"desc": """
		Desde fuera no te es difícil cortar la soga que cierra la rústica puerta y, una vez abierta, el príncipe echa a correr gritando. 
		
		Te giras rápidamente para detenerlo pero ves como se estampa contra una figura enorme. 
		
		- QUE PASA AQUIIIIII -
		
		Un enorme Troll los mira confundido, su rostro se estremece al ver a su mascota en el suelo.
	""",
	"actions": {
		"n1":{ "text":"Parece el desafío final. Si quieren huir deberás acabar con la bestia" },
	},
	"pops":{
	},
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.start_combat("combat_002")

func on_enter_room():
	pass
