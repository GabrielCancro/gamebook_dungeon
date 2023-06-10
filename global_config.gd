extends Node

var ADVENTURE_FOLDER = "adv_test"
var CURRENT_ROOM = "room_000"
var ADVENTURE
var DICES
var POPUP
var DESITIONS
var ACTION_POINTS = 10
var ADV_DATA = {
	"items":{
		"sword": {"name":"Espada", "img":"icoSword", "desc": "Una hermosa espada real, espero no tener que utilizarla"},
		"lockpick": {"name":"Ganzúa", "img":"icoLockpick", "desc": "Una precaria y corroida ganzúa metalica, podría servir para alguna cerradura estropeada."},
		"map1": {"name":"Trozo de mapa", "img":null, "desc": "Es un trozo de lo que parece el mapa de algún lugar o tesoro, solo tenemos la mitad de él."},
		"torch": {"name":"Antorcha", "img":"icoTorch", "desc": "Un trozo de madera de la fogata te sirve como antorcha."},
		"meat": {"name":"Carne", "img":"icoMeat", "desc": "Carne en dudoso estado, va, dudoso.. esta podrida."}
	},
	"vars":{},
	"rerolls":0
}

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

func add_click_fx(node):
	var tw = node.get_node_or_null("click_fx_tween")
	if tw: node.remove_child(tw)
	tw = Tween.new()
	node.add_child(tw)
	tw.interpolate_property(node,"modulate",Color(.1,.1,.1,1),Color(1,1,1,1),.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tw.start()
