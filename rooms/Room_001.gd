extends Node2D

var data = {
	"id":"r001",
	"name":"El Bosque",
	"sp":"Hay dos guardias heridos. En el fondo se ve la entrada a la cueva.",
#	"op1":{"sp":"Si señor!"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="CA_Cueva": GC.RoomManager.gotoRoom("r002")
	if name=="CA_Muerto": GC.RoomManager.gotoRoom("r004")
	if name=="CA_Herido": GC.RoomManager.gotoRoom("r003")
