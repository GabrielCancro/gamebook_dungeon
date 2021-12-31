extends Node2D

var data = {
	"id":"r001",
	"name":"Cueva Afuera",
	"sp":"Esta en las afueras de una cueva, a la izquierda un soldado herido, a la derecha uno muerto, en el centro, pues la cueva",
#	"op1":{"sp":"Si señor!"},
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="CA_Cueva": GC.RoomManager.gotoRoom("r002")
	if name=="CA_Muerto": GC.RoomManager.gotoRoom("r003")
	if name=="CA_Herido": 
		if GC.Items.useItem("sword","delete"): GC.RoomManager.gotoRoom("r004")
	if name=="CA_Item": GC.Items.takeItem($sword,$CA_Item)
		
