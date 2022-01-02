extends Node2D

var data = {
	"id":"r004",
	"name":"Guardia Muerto",
	"sp":"Sea lo que sea que lo mató parece muy peligroso.",
#	"op1":{"sp":"Mejor no"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="ClickArea1": GC.RoomManager.gotoRoom("r001")
	if name=="CA_Item": GC.Items.takeItem($sword,$CA_Item)
#	if name=="CA_Herido":
#		if GC.Items.useItem("sword","delete"): GC.RoomManager.gotoRoom("r002")

func onOption(opt):
	print("OPT "+opt)
