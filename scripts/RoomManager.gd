extends Node2D

var r1 = preload("res://rooms/Room_001.tscn")

var currentRoom = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func gotoRoom(nro):
	var rooms = get_node("/root/Game/Rooms")
	if currentRoom != null:
		rooms.remove_child(currentRoom)
#		currentRoom.queue_free()
	currentRoom = r1.instance()
	rooms.add_child(currentRoom)
