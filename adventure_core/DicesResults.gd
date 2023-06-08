extends Control

var results_data = null
var results_array = []
var results_index = -1

signal on_accept_result(id_result,result_data)

func _ready():
	$btn_next.connect("button_down",self,"show_next_result")

func show_results(val,data):
	$lb_result.text = str(val)
	visible = true
	results_data = data
	results_array = []
	results_index = -1
	for r in results_data.results:
		var result = results_data.results[r]
		result["id"] = r
		if(val>=result.ran[0] && val<=result.ran[1]): results_array.append(result)
	show_next_result()

func show_next_result():
	results_index += 1
	if(results_index<results_array.size()):
		var result = results_array[results_index]
		$Desc.text = result.tx
		emit_signal("on_accept_result",result)
	else: 
		visible = false
