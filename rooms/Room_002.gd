extends Node2D

var data = {
	"id":"r002",
	"name":"Cueva Salon",
	"sp":"Un guardia herido bla bla",
#	"op1":{"sp":"Mejor no"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="ClickArea1": GC.RoomManager.gotoRoom("r001")

func onOption(opt):
	print("OPT "+opt)
