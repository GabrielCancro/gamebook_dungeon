extends Control

var action_line_scene = preload("res://adventure_core/ActionLine.tscn")

func _ready():
	pass

func show_options():
	update_data()
	visible = true
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.3,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()

func hide_options():
	visible = false

func update_data():
	var actions = GC.get_current_room_data().actions
	for line in $Options.get_children():
		$Options.remove_child(line)
		line.queue_free()
	for node_id in actions:
		var line = action_line_scene.instance()
		line.set_node_data(actions[node_id])
		line.connect("on_click",GC.ADVENTURE.get_node("room_data_node"),"on_click_node",[node_id])
		line.modulate = Color(1,1,1,0)
		$Options.add_child(line)
		$Tween.interpolate_property(line,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_QUAD,Tween.EASE_IN)
		$Tween.start()
		yield(get_tree().create_timer(.4),"timeout")
