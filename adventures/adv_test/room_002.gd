extends Node

var room_data = {
	"image": preload("res://rooms/Room_002.jpg"),
	"desc": """
		Uno de los guardias del príncipe. Parece muy herido, no creo que sobreviva.
		
		
	- Guardia: Gracias a los dioses… coff coff, alguien me ha escuchado. 
	Escoltabamos al príncipe pero nos desviamos… coff… De repente, de la cueva salió una criatura y nos atacó. 
	Luego se llevó al príncipe. 
	No puedo rescatarle en este estado… Crees… cof coff… poder ayudarnos?
	""",
	"actions": {
		"n1":{ "text":"Yo rescatare al principe!" },
		"n2":{ "text":"Mmmm.. tal vez, dejame pensarlo" },
		"n3":{ "text":"Hir corriendo por el bosque!" },
	}
}

func on_click_node(data,node_id):
	print("CLICK IN",data)
	if node_id=="n1": 
		yield( GC.POPUP.show_popup("Los ojos del guardia brillan llenos de ilusión. Sientes una suave brisa en tu rostro y la valentia llena tu corazon"), "on_close")
	elif node_id=="n2": 
		GC.DICES.show_dices("BUSCAR")
		var dices = yield(GC.DICES,"on_dice")
		var res = GC.POPUP.set_dice_result(dices,{ "0":"F", "3":"EP", "5":"E", "7":"EA" } )
		if dices<=3:
			GC.POPUP.show_popup("No encuentras nada interesante en el lugar",false)
			yield(GC.POPUP,"on_close")
		if dices>3:
			GC.POPUP.show_popup("No muy lejos de los guardias se ve una entrada a una cueva",false)
			yield(GC.POPUP,"on_close")
			GC.DESITIONS.show_a_hidden_desition("n3")
			yield(GC.DESITIONS,"on_finish_resalt")
		if dices>5:
			GC.POPUP.show_popup("Cerca de la entrada a la cueva yace otro guardia, muerto",false)
			yield(GC.POPUP,"on_close")
			GC.DESITIONS.show_a_hidden_desition("n4")
			yield(GC.DESITIONS,"on_finish_resalt")
		if dices>7:
			GC.POPUP.show_popup("Hay un espada, parece ser del guardia muerto. Te puede hacer falta.\n\n +Nuevo item: ESPADA",false)
			yield(GC.POPUP,"on_close")
			GC.DESITIONS.hide_a_showed_desition("n2")
			yield(GC.DESITIONS,"on_finish_difuse")
		GC.POPUP.set_dice_result(null)
	else: 
		yield( GC.POPUP.show_popup("Aún no desarrollé esta opción!"), "on_close")
		
