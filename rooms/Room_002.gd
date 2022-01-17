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
	if name=="BackArrow": GC.RoomManager.gotoRoom("r001")
	if name=="CA_ZonaOscura": GC.RoomManager.gotoRoom("r005")
	if name=="CA_Comedor": GC.RoomManager.gotoRoom("r006")

func onOption(opt):
	print("OPT "+opt)
