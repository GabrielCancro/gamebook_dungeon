extends Node

var room_id = "room_001"
var image = preload("res://rooms/Room_001.jpg")
var desc = """
Hay dos guardias heridos.
"""
var actions = {
	"n1":{ "text":"Acercarse al guardia para ver que sucedio" },
	"n2":{ "text":"Buscar cosas valiosas en los alrrededores [BUSCAR:10]" },
	"n3":{ "text":"Correr rápidamente para nunca volver" }
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func on_click_node(data,node_id):
	print("CLICK NODE ",node_id,data)
	if node_id=="n1": 
		GC.POPUP.show_popup("UN POPUP RANDOM")
	if node_id=="n2": 
		GC.DICES.show_dices("BUSCAR")
		var result = yield(GC.DICES,"on_dice")
		print("ON DICE!!!!!!!!!!!")
		GC.POPUP.show_popup("SACASTE UN "+str(result),false)
		yield(GC.POPUP,"on_close")
		print("CLOSE POPUP!!!!!!!!!!!")
