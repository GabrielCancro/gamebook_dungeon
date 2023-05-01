extends Node

var ADVENTURE
var DICES
var POPUP
var DESITIONS
var ACTION_POINTS = 10
var ADV_DATA = {
	"items":{},
	"vars":{}
}
var CURRENT_ROOM = ""

# Called when the node enters the scene tree for the first time.
func get_current_room_data():
	return ADV_DATA[CURRENT_ROOM]

func add_item(id_item):
	ADV_DATA["items"][id_item] = get_current_room_data().items[id_item]
	print( "YOUR ITEMS", ADV_DATA.items.keys() )
