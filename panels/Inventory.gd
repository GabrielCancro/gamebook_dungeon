extends ColorRect

func _ready():
	$btn_hide.connect("button_down",self,"onClick",["back"])
	GC.Inventory = self
	hide()

func show():
	visible = true

func hide():
	visible = false

func onClick(arg):
	if arg=="back": hide()
