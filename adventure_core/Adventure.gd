extends Control

var room_data_node
var adv_root_data_node

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.ADVENTURE = self
	set_blocker(false)
	if !GC.CURRENT_ROOM: GC.CURRENT_ROOM = "room_000"
	#LOAD ITEMS 
	var adventure_items_node = Node.new()
	adventure_items_node.name = "adventure_items_node"
	adventure_items_node.set_script( load("res://adventures/adv_test/adventure_items.gd") )
	add_child(adventure_items_node)
	change_room(GC.CURRENT_ROOM)

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
		room_data_node.room_data['isShowed'] = false
		GC.ADV_DATA[room_id] = room_data_node.room_data
	GC.CURRENT_ROOM = room_id
	
	if room_data_node.has_method("on_enter_room"): room_data_node.on_enter_room()
	if room_data_node.has_method("on_dices_result"): $DicesResults.connect("on_accept_result",room_data_node,"on_dices_result")
	
	$Desitions.hide_options()
	$Fade.fadeOut()
	yield($Fade,"end_fade")
	
	$Narrator.start_narrator()
	yield($Narrator,"on_finish")
	$Desitions.show_options()

func set_blocker(vis):
	$Blocker.visible = vis
