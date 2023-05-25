extends Node

var ADVENTURE
var DICES
var POPUP
var DESITIONS
var ACTION_POINTS = 10
var ADV_DATA = {
	"items":{
	},
	"vars":{},
	"rerolls":0
}
var CURRENT_ROOM = "Room_000"
var CURRENT_NODE
var CURRENT_COMBAT_ID = ''

var ALL_ITEMS = {} #Content all data of all items of specific adventure (from room_000)

# Called when the node enters the scene tree for the first time.
func get_current_room_data():
	return ADV_DATA[CURRENT_ROOM]

func add_item(id_item):
	ADV_DATA["items"][id_item] = ALL_ITEMS[id_item]
	print( "YOUR ITEMS", ADV_DATA.items )

func get_item(id_item):
	if ADV_DATA["items"].has(id_item):
		return ADV_DATA["items"][id_item]
	else: return null

func remove_item(id_item):
	ADV_DATA["items"].erase(id_item)
	print( "YOUR ITEMS", ADV_DATA.items )
	
func set_gamevar(key,value=null):
	if value==null: ADV_DATA["vars"].erase(key)
	else: ADV_DATA["vars"][key] = value
	print( "YOUR VARS", ADV_DATA.vars )

func get_gamevar(key):
	if ADV_DATA["vars"].has(key): 
		return ADV_DATA["vars"][key]
	else: return null

func start_combat( combat_id ):
	CURRENT_COMBAT_ID = combat_id
	get_tree().change_scene("res://adventure_core/Combat.tscn")

func end_game():
	get_tree().change_scene("res://scenes/Main.tscn")
