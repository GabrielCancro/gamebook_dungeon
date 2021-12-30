extends Node2D

var data = {
	"id":"003",
	"name":"Guardia Herido",
	"sp":"Un guardia herido bla bla",
#	"op1":{"sp":"Mejor no"},
}

func _ready():
	GC.Game.show_desc(data[GC.lang])
	print( "Room " + data.id + ": ", GC.RoomData[data.id] )

func onClickAreaMethod(name):
	if name=="ClickArea1": GC.RoomManager.gotoRoom("001")

func onOption(opt):
	print("OPT "+opt)
