extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ClickArea.connect("onClickArea",self,"onClick",["mancha"])

func onClick(arg,type):
	if type=="mancha": 
		print("CLICK EN MANCHA!")
