extends Node

var desc = """
Caminas por el bosque cuando escuchas un grito.\n
Corres en su dirección y te encuentras con dos guardias malheridos.\n
Son guardias reales. Uno de ellos parece seguir con vida y te pide ayuda. 
"""

var actions = {
	"n1":{ "text":"Acercarse al guardia para ver que sucedio" },
	"n2":{ "text":"Buscar cosas valiosas en los alrrededores [BUSCAR:10]" },
	"n3":{ "text":"Correr rápidamente para nunca volver" }
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("LOAD ROOM 000")
	get_parent().set_room_data(desc,actions)

func on_click_node(data,node_id):
	print("CLICK NODE ",node_id,data)
	if node_id=="n1": 
		GC.POPUP.show_popup("UN POPUP RANDOM")
	if node_id=="n2": 
		GC.DICES.show_dices("BUSCAR")
		var result = yield(GC.DICES,"on_dice")
		print("ON DICE!!!!!!!!!!!")
		GC.POPUP.show_popup("SACASTE UN "+str(result))
		yield(GC.POPUP,"on_close")
		print("CLOSE POPUP!!!!!!!!!!!")
