extends Node

var lang = "sp"
var Game = null
var Items = null
var RoomManager = null
var Inventory = null
var RoomData = {}
var pj_weapon = "sword"
var weapons = {
	"hand": 8,
	"sword": 18
}
var screen = Vector2( ProjectSettings.get_setting("display/window/size/width"),  ProjectSettings.get_setting("display/window/size/height") )
signal colorRectTransition_in_completed
signal colorRectTransition_out_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func showFloatText(text,pos):
	var ft = preload("res://panels/FloatText.tscn").instance()
	Game.add_child(ft)
	ft.showText(text, (pos - ft.rect_size/2) )

func colorRectTransition():
	var cr = Game.get_node("ColorRect")
	var tw = cr.get_node("Tween")
	cr.visible = true
	tw.interpolate_property(cr, "modulate",
		cr.modulate, Color(0,0,0,1), .2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
	yield(tw,"tween_completed")
	emit_signal("colorRectTransition_in_completed")
	tw.interpolate_property(cr, "modulate",
		Color(0,0,0,1), Color(0,0,0,0), .2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
	yield(tw,"tween_completed")
	emit_signal("colorRectTransition_out_completed")
	cr.visible = false

func getPjDamage():
	return weapons[pj_weapon]

func startMinigame(minigameName):
	var MG
	if minigameName == "combat": MG = preload("res://panels/Combat.tscn").instance()
	if minigameName == "locks": MG = preload("res://panels/Locks.tscn").instance()
	get_node("/root").add_child(MG)
	MG.startMinigame()
	
