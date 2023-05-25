extends Node

var room_data = {
	"name": "HienaMuere",
	"image": null,
	"desc": """
		Luego de una gran batalla contra la hiena, logras dar el golpe final y matar al animal.
		Estas agitado, lleno de pelos y rasguños.
	""",
	"actions": {
		"n1":{ "text":"Sigues vivo, eso es bueno" },
	},
	"pops":{
	},
}

func on_click_node(node_data,node_id):
	print("CLICK IN",node_data)
	var room_data = GC.get_current_room_data();
	if node_id=="n1": 
		GC.ADVENTURE.change_room("room_008") 

func on_enter_room():
	pass
