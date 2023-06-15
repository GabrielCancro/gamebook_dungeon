extends Node

var room_data = {
	"name": "El Bosque",
	"room_id": "room_001",
	"image": preload("res://adventures/adv_test/imgs/room_001 el bosque.jpg"),
	"desc": """
		No dudas en correr en su dirección. 
		El grito te guía a través de los árboles fuera del camino. 
		\nCuando llegas te encuentras con un guardia herido. Es un guardia Real. 
		Aún sigue con vida y te pide ayuda.
	""",
	"actions": {
		"n1":{ "text":"Habla con el guardia" },
		"n2":{ "text":"Parece la escena de un crimen, no te será difícil encontrar pistas (revisar la zona)", "isDice": 1 },
		"n3":{ "text":"Entra en la cueva", "isHidden":true },
		"n4":{ "text":"Acercate al guardia muerto", "isHidden":true }
	},
	"pops":{
		"p1":"""
			En el suelo yace otro guardia, muerto. Su rostro es jóven, se lo ve con poca experiencia. 
			En cierta forma te recuerda a ti. Sea lo que sea que lo mató, espero no tener que enfrentarlo.
		"""
	},
	"dices_buscar":{
		"abName":"Buscar",
		"results":{
			"r0":{"ran":[-99,2],"tx":"No encuentras nada interesante en el lugar"},
			"r1":{"ran":[3,99],"tx":"No muy lejos de los guardias se ve la entrada a una cueva","newDesition":"n3"},
			"r2":{"ran":[5,99],"tx":"Cerca de la entrada a la cueva yace otro guardia, muerto","newDesition":"n4"},
			"r3":{"ran":[7,99],"tx":"Hay un espada, parece ser del guardia muerto. Te puede hacer falta","addItem":"sword"}
		}
	}

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_002")
	elif node_id=="n2": 
		GC.DICES.show_dices(room_data.dices_buscar)
	elif node_id=="n3": 
		GC.ADVENTURE.change_room("room_003")
	elif node_id=="n4": 
		yield(GC.POPUP.show_popup(room_data.pops.p1), "on_close")

func on_dices_result(res):
	if res.id=="r0":
		pass
	if res.id=="r1":
		pass
	if res.id=="r2":
		pass
	if res.id=="r3":
		GC.DESITIONS.set_visible_desition("n2",false)
