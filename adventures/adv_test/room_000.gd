extends Node

var room_data = {
	"name": "Prologo",
	"room_id": "room_000",
	"image": null,
	"desc": """Caminas por el bosque cuando escuchas un grito.
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

var all_items = {
	"sword": {"name":"Espada", "img":null, "desc": "Una hermosa espada real, espero no tener que utilizarla"},
	"lockpick": {"name":"Ganzúa", "img":null, "desc": "Una precaria y corroida ganzúa metalica, podría servir para alguna cerradura estropeada."},
	"map1": {"name":"Trozo de mapa", "img":null, "desc": "Es un trozo de lo que parece el mapa de algún lugar o tesoro, solo tenemos la mitad de él."},
	"torch": {"name":"Antorcha", "img":null, "desc": "Un trozo de madera de la fogata te sirve como antorcha."},
	"meat": {"name":"Carne", "img":null, "desc": "Carne en dudoso estado, va, dudoso.. esta podrida."}
}

var all_combats = {
	"c1": {}
}

func _ready():
	GC.ALL_ITEMS = all_items
	GC.ALL_COMBATS = all_combats

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_001")
