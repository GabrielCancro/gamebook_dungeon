extends Node2D

var data = {
	"id":"r003",
	"name":"Guardia Herido",
	"sp":"Uno de los guardías del príncipe. Parece muy herido, no creo que sobreviva.",
#	"op1":{"sp":"Mejor no"},
}

var dialog = {
	"sp": """-Guarida Herido-
		Te agradezco la ayuda… coff coff… apresúrate… no se que le hará esa cosa al príncipe...
	"""
}

func _ready():
	pass

func onClickAreaMethod(name):
	if name=="BackArrow": GC.RoomManager.gotoRoom("r001")
	if name=="ClickGuard": GC.Game.show_desc(dialog[GC.lang],3)

func onOption(opt):
	print("OPT "+opt)
