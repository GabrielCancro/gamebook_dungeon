extends Node2D

func _ready():
	$btn_main.connect("button_down",self,"onClick",["main"])

func onClick(arg):
	if arg=="main": get_tree().change_scene("res://scenes/Main.tscn")
