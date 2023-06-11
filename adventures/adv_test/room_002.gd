extends Node

var room_data = {
	"name": "Guardia Herido",
	"image": preload("res://adventures/adv_test/imgs/room_002 guardia herido.jpg"),
	"desc": """
		Parece muy herido, no creo que sobreviva.
		- Gracias a los dioses… coff coff, alguien me ha escuchado.
		No puedo rescatar al príncipe en este estado… Crees… cof coff… poder ayudarnos?
	""",
	"actions": {
		"n1":{ "text":"Yo rescataré al principe!" },
		"n2":{ "text":"Mmmm.. tal vez, dejame pensarlo" },
		"n3":{ "text":"Huir corriendo por el bosque!" },
		"n4":{ "text":"Dejemos al herido en paz", "isHidden":true },
	},
	"pops":{
		"p1":"Los ojos del guardia brillan llenos de ilusión. Sientes una suave brisa en tu rostro y la valentia llena tu corazón.\n\n(+5 CONCENTRACIÓN)",
		"p2":"Te lo piensas por un rato mirando al cielo, y ves un hermoso pájaro sobrevolando la escena, podría ser una señal, aunque seguro solo es un pájaro.",
		"p3":"Realmente harías eso? Mejor vuelve y haz lo que un heroe debe hacer!"
	}
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.POPUP.show_popup(room_data.pops.p1)
		GC.ACTION_POINTS += 5
		GC.DESITIONS.set_visible_desition("n1",false)
		GC.DESITIONS.set_visible_desition("n2",false)
		GC.DESITIONS.set_visible_desition("n3",false)
		GC.DESITIONS.set_visible_desition("n4",true)
	elif node_id=="n2": 
		GC.POPUP.show_popup(room_data.pops.p2)
		GC.DESITIONS.set_visible_desition("n4",true)
	elif node_id=="n3":
		GC.POPUP.show_popup(room_data.pops.p3)
		GC.DESITIONS.set_visible_desition("n3",false)
		GC.DESITIONS.set_visible_desition("n4",true)
	elif node_id=="n4":
		GC.ADVENTURE.change_room('room_001')
