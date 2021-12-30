extends Node2D

onready var currentRoom = null
signal change_room

var rooms = {
	"r001": preload("res://rooms/Room_001.tscn").instance(),
	"r002": preload("res://rooms/Room_002.tscn").instance(),
	"r003": preload("res://rooms/Room_003.tscn").instance(),
	"r004": preload("res://rooms/Room_004.tscn").instance(),
}

func _ready():
	GC.RoomManager = self

func gotoRoom(id):
	if GC.item_selected != -1: return
	if currentRoom != null:
		remove_child(currentRoom)
	currentRoom = rooms[id]
	add_child(currentRoom)
	print(currentRoom.data)
	currentRoom.data["visited"] = true
	GC.Game.show_desc(currentRoom.data[GC.lang])
	emit_signal("change_room")
