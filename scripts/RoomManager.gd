extends Node2D

onready var currentRoom = null

func _ready():
	GC.RoomManager = self

func gotoRoom(id):
	if !GC.RoomData.has(id): GC.RoomData[id] = {}
	if currentRoom != null:
		remove_child(currentRoom)
		currentRoom.queue_free()
	currentRoom = load("res://rooms/Room_"+id+".tscn").instance()
	add_child(currentRoom)
	GC.RoomData[id]["visited"] = true
