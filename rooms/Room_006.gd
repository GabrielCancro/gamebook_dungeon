extends Node2D

var data = {
	"id":"r006",
	"name":"Comedor",
	"sp":"Una pequeña antorcha ilumina la sala. Un millar de huesos adorna el lugar.",
#	"op1":{"sp":"Mejor no"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="BackArrow": GC.RoomManager.gotoRoom("r002")
	if name=="CA_Item": GC.Items.takeItem($torch,$CA_Item)

func onOption(opt):
	print("OPT "+opt)
