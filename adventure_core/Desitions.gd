extends Control

var action_line_scene = preload("res://adventure_core/ActionLine.tscn")

func _ready():
	GC.DESITIONS = self

func show_options():
	update_data()
	visible = true
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,.5),Color(1,1,1,1),.3,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()

func hide_options():
	visible = false

func update_data(anim=true):
	var actions = GC.get_current_room_data().actions
	for line in $Options.get_children():
		$Options.remove_child(line)
		line.queue_free()
	for node_id in actions:
		if !actions[node_id].has("isHidden"): actions[node_id]["isHidden"] = false
		if actions[node_id].isHidden: continue
		actions[node_id]["node_id"] = node_id
		var line = add_line(actions[node_id])
		if anim:
			line.modulate = Color(1,1,1,0)
			$Tween.interpolate_property(line,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_QUAD,Tween.EASE_IN,line.get_index()*.3)
			$Tween.start()

func add_line(node_data):
	var line = action_line_scene.instance()
	line.set_node_data(node_data)
	line.connect("on_click",GC.ADVENTURE.get_node("room_data_node"),"on_click_node",[node_data.node_id])
	$Options.add_child(line)
	return line

func resalt_node(node_id):
	for line in $Options.get_children():
		if line.data.node_id == node_id:
			$Tween.interpolate_property(line,"rect_scale",Vector2(1.2,1.2),Vector2(1,1),.7,Tween.TRANS_QUAD,Tween.EASE_OUT)
			$Tween.start()
