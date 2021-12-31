extends ColorRect

func _ready():
	$btn_hide.connect("button_down",self,"onClick",["back"])
	$btn_quit.connect("button_down",self,"onClick",["quit"])
	GC.Inventory = self
	hide()

func show():
	visible = true

func hide():
	visible = false

func onClick(arg):
	if arg=="back": hide()
	if arg=="quit": get_tree().change_scene("res://scenes/Main.tscn")
