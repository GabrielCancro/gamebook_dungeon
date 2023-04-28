extends Node

var room_id = "room_000"
var image = null
var desc = """
Caminas por el bosque cuando escuchas un grito.
Corres en su dirección y te encuentras con un guardia herido. Es un guardia Real. 
Aún sigue con vida y te pide ayuda.
Escoltaban al príncipe a través del bosque cuando encontraron una cueva. 
El príncipe quiso explorar pero sus guardias se lo negaron. 
Y mientras hablaban, una criatura salió, los atacó y se llevó al príncipe. 
Encuentra al príncipe y tendrás nuestra gratitud.
"""
var actions = {
	"n1":{ "text":"-No todos los días se presenta una situación para convertirse en una heroína, te dices mientras miras con atención el túnel que conduce a la cueva." },
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("LOAD ROOM 000")
#	GC.set_current_room(room_id)

func on_click_node(data,node_id):
	print("CLICK NODE ",node_id,data)
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_001")
