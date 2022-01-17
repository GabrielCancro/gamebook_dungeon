extends Node2D

onready var currentRoom = null
signal change_room

var rooms = {
	"r001": preload("res://rooms/Room_001.tscn").instance(),
	"r002": preload("res://rooms/Room_002.tscn").instance(),
	"r003": preload("res://rooms/Room_003.tscn").instance(),
	"r004": preload("res://rooms/Room_004.tscn").instance(),
	"r005": preload("res://rooms/Room_005.tscn").instance(),
	"r006": preload("res://rooms/Room_006.tscn").instance(),
}

func _ready():
	GC.RoomManager = self

func gotoRoom(id):
	if GC.Items.item_selected != -1: return
	GC.colorRectTransition()
	yield(GC,"colorRectTransition_in_completed")
	if currentRoom != null:
		remove_child(currentRoom)
	currentRoom = rooms[id]
	add_child(currentRoom)
	print(currentRoom.data)
	currentRoom.data["visited"] = true
	GC.Game.show_desc("")
	yield(GC,"colorRectTransition_out_completed")
	GC.Game.show_desc(currentRoom.data[GC.lang])
	GC.Game.get_node("roomTitle").text = currentRoom.data.id+" - "+currentRoom.data.name
	emit_signal("change_room")
	
