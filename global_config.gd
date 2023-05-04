extends Node

var ADVENTURE
var DICES
var POPUP
var DESITIONS
var ACTION_POINTS = 10
var ADV_DATA = {
	"items":{},
	"vars":{},
	"rerolls":0
}
var CURRENT_ROOM = ""
var CURRENT_NODE

# Called when the node enters the scene tree for the first time.
func get_current_room_data():
	return ADV_DATA[CURRENT_ROOM]

func add_item(id_item):
	ADV_DATA["items"][id_item] = get_current_room_data().items[id_item]
	print( "YOUR ITEMS", ADV_DATA.items )

func set_gamevar(key,value=null):
	if value==null: ADV_DATA["vars"].erase(key)
	else: ADV_DATA["vars"][key] = value
	print( "YOUR VARS", ADV_DATA.vars )
