extends Node

var desc = """
Caminas por el bosque cuando escuchas un grito.\n
Corres en su dirección y te encuentras con dos guardias malheridos.\n
Son guardias reales. Uno de ellos parece seguir con vida y te pide ayuda. 
"""

var actions = {
	"n1":{ "text":"Acercarse al guardia para ver que sucedio" },
	"n2":{ "text":"Buscar cosas valiosas en los alrrededores" },
	"n3":{ "text":"Correr rápidamente para nunca volver" }
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("LOAD ROOM 000")
	get_parent().set_room_data(desc,actions)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
