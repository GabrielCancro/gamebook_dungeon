extends Node

var all_items = {
	"sword": {"name":"Espada", "img":null, "desc": "Una hermosa espada real, espero no tener que utilizarla"},
	"lockpick": {"name":"Ganzúa", "img":null, "desc": "Una precaria y corroida ganzúa metalica, podría servir para alguna cerradura estropeada."},
	"map1": {"name":"Trozo de mapa", "img":null, "desc": "Es un trozo de lo que parece el mapa de algún lugar o tesoro, solo tenemos la mitad de él."},
	"torch": {"name":"Antorcha", "img":null, "desc": "Un trozo de madera de la fogata te sirve como antorcha."},
	"meat": {"name":"Carne", "img":null, "desc": "Carne en dudoso estado, va, dudoso.. esta podrida."}
}

func _ready():
	GC.ALL_ITEMS = all_items
