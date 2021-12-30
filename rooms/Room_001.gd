extends Node2D

var data = {
	"id":"001",
	"name":"Cueva Afuera",
	"sp":"Esta en las afueras de una cueva, a la izquierda un soldado herido, a la derecha uno muerto, en el centro, pues la cueva",
#	"op1":{"sp":"Si señor!"},
}

func _ready():
	GC.Game.show_desc(data[GC.lang])
	print( "Room " + data.id + ": ", GC.RoomData[data.id] )

func onClickAreaMethod(name):
	if name=="CA_Cueva": GC.RoomManager.gotoRoom("002")
	if name=="CA_Muerto": GC.RoomManager.gotoRoom("003")
	if name=="CA_Herido": GC.RoomManager.gotoRoom("004")
