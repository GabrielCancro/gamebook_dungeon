extends Node2D

var id = "002"
var _desc = {
	"sp":"Esto se esta poniendo verdaderamente azulado",
	"en":"jjj"
}
var options = [
	{"sp":"si señor!", "en":"yes sior"},
	{"sp":"no!", "en":"no!"},
]
var data = null

func _ready():
	GC.Game.show_desc(_desc[GC.lang])
	print( "Room " + id + ": ", GC.RoomData[id] )

func onClickAreaMethod(name):
	if name=="ClickArea1": GC.RoomManager.gotoRoom("001")

func onOption(opt):
	print("OPT "+opt)
