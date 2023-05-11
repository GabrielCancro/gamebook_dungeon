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
var CURRENT_ROOM = null
var CURRENT_NODE
var CURRENT_COMBAT_DATA

var ALL_ITEMS = {} #Content all data of all items of specific adventure (from room_000)
var ALL_COMBATS = {
	"test":{"win_room":"room_002","lose_room":"room_000"}
} #Content all data of all combats of specific adventure (from room_000)

# Called when the node enters the scene tree for the first time.
func get_current_room_data():
	return ADV_DATA[CURRENT_ROOM]

func add_item(id_item):
	ADV_DATA["items"][id_item] = ALL_ITEMS[id_item]
	print( "YOUR ITEMS", ADV_DATA.items )

func set_gamevar(key,value=null):
	if value==null: ADV_DATA["vars"].erase(key)
	else: ADV_DATA["vars"][key] = value
	print( "YOUR VARS", ADV_DATA.vars )

func start_combat( combat_id ):
	CURRENT_COMBAT_DATA = ALL_COMBATS[combat_id]
	CURRENT_COMBAT_DATA["combat_id"] = combat_id
	get_tree().change_scene("res://adventure_core/Combat.tscn")
