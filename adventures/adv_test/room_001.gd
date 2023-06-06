extends Node

var room_data = {
	"name": "El Bosque",
	"room_id": "room_001",
	"image": preload("res://adventures/adv_test/imgs/room_001 el bosque.jpg"),
	"desc": """
		Y mientras ves como los pájaros vuelan por sobre los árboles y los venados corren por entre los arbustos del bosque, oyes un grito. Un grito que te hiela la sangre.
		\nNo dudas en correr en su dirección. 
		El grito te guía a través de los árboles fuera del camino. 
		Cuando llegas te encuentras con un guardia herido. Es un guardia Real. 
		Aún sigue con vida y te pide ayuda.
	""",
	"actions": {
		"n1":{ "text":"Habla con el guardia" },
		"n2":{ "text":"Parece la escena de un crimen, no te será difícil encontrar pistas (revisar la zona)", "isDice": 1 },
		"n3":{ "text":"Entra en la cueva", "isHidden":true },
		"n4":{ "text":"Acercate al guardia muerto", "isHidden":true }
	},
	"pops":{
		"r1":"No encuentras nada interesante en el lugar",
		"r2":"No muy lejos de los guardias se ve la entrada a una cueva",
		"r3":"Cerca de la entrada a la cueva yace otro guardia, muerto",
		"r4":"Hay un espada, parece ser del guardia muerto. Te puede hacer falta.\n\n +Nuevo item: ESPADA",
		"p1":"""
			En el suelo yace otro guardia, muerto. Su rostro es jóven, se lo ve con poca experiencia. 
			En cierta forma te recuerda a ti. Sea lo que sea que lo mató, espero no tener que enfrentarlo.
		"""
	},

}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_002")
	elif node_id=="n2": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "3":"EP", "5":"E", "7":"EA" } )
		if dices<3:
			yield(GC.POPUP.show_popup(room_data.pops.r1), "on_close")
		if dices>=3:
			yield(GC.POPUP.show_popup(room_data.pops.r2), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n3"), "on_finish_resalt" )
		if dices>=5:
			yield(GC.POPUP.show_popup(room_data.pops.r3), "on_close")
			yield( GC.DESITIONS.show_a_hidden_desition("n4"), "on_finish_resalt" )
		if dices>=7:
			yield(GC.POPUP.show_popup(room_data.pops.r4), "on_close")
			GC.add_item("sword") 
			yield( GC.DESITIONS.hide_a_showed_desition("n2"), "on_finish_difuse")
		GC.POPUP.set_dice_result(null)
	elif node_id=="n3": 
		GC.ADVENTURE.change_room("room_003")
	elif node_id=="n4": 
		yield(GC.POPUP.show_popup(room_data.pops.p1), "on_close")
		
