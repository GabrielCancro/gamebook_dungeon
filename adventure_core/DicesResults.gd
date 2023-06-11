extends Control

var results_data = null
var results_array = []
var results_index = 0

signal on_accept_result(id_result,result_data)

func _ready():
	$btn_next.connect("button_down",self,"click_next")

func show_results(val,data):
	$Result.modulate.a = 0
	$Result.texture = load(data.result_texture) 
	$Result/Label.text = str(val)
	$Desc.visible = false
	$AddItem.visible = false
	$btn_next.visible = false
	visible = true
	results_data = data
	results_array = []
	results_index = 0
	for r in results_data.results:
		var result = results_data.results[r]
		result["id"] = r
		if(val>=result.ran[0] && val<=result.ran[1]): results_array.append(result)
	
	$Tween.interpolate_property($Result,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property($Result,"rect_position",$Result.rect_position+Vector2(0,300),$Result.rect_position,.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	show_result()

func show_result():
	var result = results_array[results_index]
	$btn_next.visible = false
	$Desc.visible = true
	$AddItem.visible = false
	$Desc.modulate.a = 0
	$AddItem.modulate.a = 0
	$btn_next.modulate.a = 0
	$Desc.text = result.tx
	
	$Tween.remove_all()
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

	$Tween.interpolate_property($Desc,"modulate",Color(1,1,1,.1),Color(1,1,1,1),.6)
	$Tween.interpolate_property($AddItem,"modulate",Color(1,1,1,.1),Color(1,1,1,1),.6)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	$btn_next.visible = true
	emit_signal("on_accept_result",result)

func click_next():
	results_index += 1
	if(results_index<results_array.size()):
		show_result()
	else: 
		visible = false
		GC.DESITIONS.update_data()
