extends Node2D

var data = {
	"id":"r002",
	"name":"Entrada a la cueva",
	"sp":"La entrada húmeda y oscura de una típica cueva. Una tenue luz proviene de la sala siguiente.",
#	"op1":{"sp":"Mejor no"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="ClickArea1": GC.RoomManager.gotoRoom("r001")

func onOption(opt):
	print("OPT "+opt)
