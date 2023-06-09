extends Control

var action_line_scene = preload("res://adventure_core/ActionLine.tscn")

signal on_finish_resalt
signal on_finish_difuse

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
		if line.name == "Line": continue
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
	GC.ADVENTURE.set_blocker(true)
	for line in $Options.get_children():
		if line.name == "Line": continue
		if line.data.node_id == node_id:
			$Tween.interpolate_property(line,"rect_scale",Vector2(1.2,1.2),Vector2(1,1),.7,Tween.TRANS_QUAD,Tween.EASE_OUT)
			$Tween.start()
	yield(get_tree().create_timer(1.2),"timeout")
	GC.ADVENTURE.set_blocker(false)
	emit_signal("on_finish_resalt")

func difuse_node(node_id):
	GC.ADVENTURE.set_blocker(true)
	for line in $Options.get_children():
		if line.name == "Line": continue
		if line.data.node_id == node_id:
			$Tween.interpolate_property(line,"modulate",Color(1,1,1,1),Color(1,1,1,0),.7,Tween.TRANS_QUAD,Tween.EASE_OUT)
			$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	GC.ADVENTURE.set_blocker(false)
	GC.get_current_room_data().actions[node_id]["isHidden"] = true
	update_data(false)
	emit_signal("on_finish_difuse")
	
#func show_a_hidden_desition(node_id):
#	GC.get_current_room_data().actions[node_id].isHidden = false
#	update_data(false)
#	resalt_node(node_id)
#	return self;

func set_visible_desition(node_id,_visible):
	GC.get_current_room_data().actions[node_id]["isHidden"] = !_visible
	GC.get_current_room_data().actions[node_id]["isNew"] = _visible
	print("CHANGE ",GC.get_current_room_data().actions[node_id])

#func hide_a_showed_desition(node_id):
#	difuse_node(node_id)
#	return self;
