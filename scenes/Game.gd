extends Node2D

func _ready():
	$btn_main.connect("button_down",self,"onClick",["main"])
	$btn_inventory.connect("button_down",self,"onClick",["inv"])

func onClick(arg):
	if arg=="main": get_tree().change_scene("res://scenes/Main.tscn")
	if arg=="inv": $Inventory.show()
