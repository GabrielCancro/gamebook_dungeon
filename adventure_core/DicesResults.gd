extends Control

var results_data = null
var results_array = []
var results_index = 0

signal on_accept_result(id_result,result_data)

func _ready():
	$btn_next.connect("button_down",self,"click_next")

func show_results(val,data):
	$lb_result.text = str(val)
	visible = true
	results_data = data
	results_array = []
	results_index = 0
	for r in results_data.results:
		var result = results_data.results[r]
		result["id"] = r
		if(val>=result.ran[0] && val<=result.ran[1]): results_array.append(result)
	show_result()

func show_result():
	var result = results_array[results_index]
	$Desc.text = result.tx
	$AddItem.visible = false
	if "newDesition" in result:
		GC.DESITIONS.set_visible_desition(result.newDesition,true)
		$Desc.text +="\n\n+Nueva decisión disponible+" 
		$Desc.text +="\n"+GC.get_current_room_data().actions[result.newDesition].text
	if "addItem" in result:
		GC.add_item(result.addItem)
		$Desc.text +="\n\n+Nuevo objeto adquirido+"
		$Desc.text +="\n"+GC.get_item(result.addItem).name
		$AddItem.texture = load("res://adventures/"+GC.ADVENTURE_FOLDER+"/imgs/"+GC.get_item(result.addItem).img+".png")
		$AddItem.visible = true
	emit_signal("on_accept_result",result)

func click_next():
	results_index += 1
	if(results_index<results_array.size()):
		show_result()
	else: 
		visible = false
		GC.DESITIONS.update_data()
