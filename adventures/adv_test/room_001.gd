extends Node

var room_data = {
	"room_id": "room_001",
	"image": preload("res://rooms/Room_001.jpg"),
	"desc": """
		Hay dos guardias heridos.
	""",
	"actions": {
		"n1":{ "text":"Acercarse al guardia para ver que sucedio" },
		"n2":{ "text":"Buscar cosas valiosas en los alrrededores [BUSCAR:10]" },
		"n3":{ "text":"Correr rápidamente para nunca volver", "isHidden":true }
	}
}

func on_click_node(data,node_id):
	print("CLICK IN",data)
	if node_id=="n1": 
		GC.POPUP.show_popup("UN POPUP RANDOM")
	if node_id=="n2": 
		GC.DICES.show_dices("BUSCAR")
		var result = yield(GC.DICES,"on_dice")
		GC.POPUP.show_popup("SACASTE UN "+str(result),false)
		yield(GC.POPUP,"on_close")
		GC.ADVENTURE.show_a_hidden_desition("n3")
