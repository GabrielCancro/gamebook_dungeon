extends Node2D

var id = "001"
var _desc = {
	"sp":"Una habitacion muy muy oscura, repleta de abundante oscuridad",
	"en":"jjj"
}
var options = []
var data = null

func _ready():
	GC.Game.show_desc(_desc[GC.lang])
	print( "Room " + id + ": ", GC.RoomData[id] )

func onClickAreaMethod(name):
	if name=="ClickArea": GC.RoomManager.gotoRoom("002")
