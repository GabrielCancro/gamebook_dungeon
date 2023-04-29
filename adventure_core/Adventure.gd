extends Control

var room_data_node
var adv_root_data_node

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.ADVENTURE = self
	set_blocker(false)
	change_room("room_000")

func change_room(room_id):
	$Fade.fadeIn()
	yield($Fade,"end_fade")
	$Narrator.clear_narrator()
	room_data_node = get_node_or_null("room_data_node")
	if room_data_node: 
		remove_child(room_data_node)
		room_data_node.queue_free()
	room_data_node = Node.new()
	room_data_node.name = "room_data_node"
	room_data_node.set_script( load("res://adventures/adv_test/"+room_id+".gd") )
	add_child(room_data_node)
	if (!GC.ADV_DATA.has(room_id)):
		room_data_node.room_data['room_id'] = room_id
		GC.ADV_DATA[room_id] = room_data_node.room_data
	GC.CURRENT_ROOM = room_id
	
	$Desitions.hide_options()
	$Fade.fadeOut()
	yield($Fade,"end_fade")
	
	$Narrator.start_narrator()
	yield($Narrator,"on_finish")
	$Desitions.show_options()

func set_blocker(vis):
	$Blocker.visible = vis
