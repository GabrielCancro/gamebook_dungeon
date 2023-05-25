extends Node

var room_data = {
	"name": "Prologo",
	"room_id": null,
	"image": null,
	"desc": """
		Caminas por el bosque cuando escuchas un grito.
		Corres en su dirección y te encuentras con un guardia herido. Es un guardia Real. 
		Aún sigue con vida y te pide ayuda.
		Escoltaban al príncipe a través del bosque cuando encontraron una cueva. 
		El príncipe quiso explorar pero sus guardias se lo negaron. 
		Y mientras hablaban, una criatura salió, los atacó y se llevó al príncipe. 
		Encuentra al príncipe y tendrás nuestra gratitud.
	""",
	"actions": {
		"n1":{ "text":"No todos los días se presenta una situación para convertirse en una heroína, te dices mientras miras con atención el túnel que conduce a la cueva." },
	}
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_001")
