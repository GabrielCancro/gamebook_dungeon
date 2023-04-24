extends Control

var adv_root_script = preload("res://adventures/adv_test/adv_root_data.gd")
var action_line_scene = preload("res://adventure_core/ActionLine.tscn")

var room_data_node
var adv_root_data_node

# Called when the node enters the scene tree for the first time.
func _ready():
	adv_root_data_node = Node.new()
	adv_root_data_node.name = "adv_root_data_node"
	adv_root_data_node.set_script(adv_root_script)
	add_child(adv_root_data_node)
	change_room("room_000")

func change_room(id_room):
	var room_data_node = get_node_or_null("room_data_node")
	if room_data_node: 
		remove_child(room_data_node)
		room_data_node.queue_free()
	room_data_node = Node.new()
	room_data_node.name = "room_data_node"
	room_data_node.set_script( adv_root_data_node.room_scripts[id_room] )
	add_child(room_data_node)

func set_room_data(desc,actions):
	$Narrator/Desc.text = desc
	$Narrator/Tween.interpolate_property($Narrator/Desc,"percent_visible",0,1,desc.length()/40,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Narrator/Tween.start()	
	for line in $Desitions/Options.get_children():
		$Desitions/Options.remove_child(line)
		line.queue_free()
	for node_id in actions:
		var line = action_line_scene.instance()
		line.set_node_data(actions[node_id])
		$Desitions/Options.add_child(line)
	yield($Narrator/Tween,"tween_completed")
	$Desitions.close_options()
