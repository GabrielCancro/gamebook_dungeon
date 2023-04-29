extends Node

var ADVENTURE
var DICES
var POPUP
var DESITIONS
var ACTION_POINTS = 15
var ADV_DATA = {}
var CURRENT_ROOM = ""

# Called when the node enters the scene tree for the first time.
func get_current_room_data():
	return ADV_DATA[CURRENT_ROOM]
