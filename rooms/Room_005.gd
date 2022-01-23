extends Node2D

var data = {
	"id":"r005",
	"name":"Zona Oscura",
	"sp":"Tal vez haya algo útil por aquí, pero no puedes ver nada.",
#	"op1":{"sp":"Mejor no"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="BackArrow": GC.RoomManager.gotoRoom("r002")
	if name=="CA_ItemTorch": 
		if GC.Items.useItem("torch","none"):
			GC.showFloatText("Ahora puedes ver!!", $CA_ItemTorch.position)

func onOption(opt):
	print("OPT "+opt)
