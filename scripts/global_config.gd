extends Node

var lang = "sp"
var Game = null
var Items = null
var RoomManager = null
var Inventory = null
var RoomData = {}
var screen = Vector2( ProjectSettings.get_setting("display/window/size/width"),  ProjectSettings.get_setting("display/window/size/height") )
var item_selected = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func showFloatText(text,pos):
	var ft = preload("res://panels/FloatText.tscn").instance()
	Game.add_child(ft)
	ft.showText(text, (pos - ft.rect_size/2) )
