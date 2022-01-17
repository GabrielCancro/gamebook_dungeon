extends Node2D

var data = {
	"id":"r006",
	"name":"Comedor",
	"sp":"...............................",
#	"op1":{"sp":"Mejor no"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="BackArrow": GC.RoomManager.gotoRoom("r002")

func onOption(opt):
	print("OPT "+opt)
