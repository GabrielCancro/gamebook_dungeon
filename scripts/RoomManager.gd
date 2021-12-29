extends Node2D

onready var currentRoom = null

func _ready():
	GC.RoomManager = self

func gotoRoom(nro):
	if !GC.RoomData.has(nro): 
		GC.RoomData[nro] = {}
	if currentRoom != null:
		remove_child(currentRoom)
		currentRoom.queue_free()
	currentRoom = load("res://rooms/Room_"+nro+".tscn").instance()
	add_child(currentRoom)
	GC.RoomData[nro]["visited"] = true
