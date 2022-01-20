extends Node2D

var state
var key_index
const max_keys = 5
var key
var trap
var gan


# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_back.connect("button_down",self,"onClick",["back"])
	set_process(false)

func startMinigame():
	set_process(true)
	visible = true
	key_index = 0
	state = "none"
	for i in range(1,5): get_node("keys/k"+str(i)).position.y = 450
	gan = 3
	$Label.text = "Ganzuas: "+str(gan)
	$btn_back.text = "Desistir"
	onKeySuccess()

func endMinigame():
	set_process(false)
	visible = false
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "down":
		if gan <= 0: state = "none"
		key.position.y -= 8
		if(key.position.y<100):
			state = "none"
	else: if state == "up":
		if abs(key.position.y-trap.position.y)<20:
			key.position.y = trap.position.y
			onKeySuccess()
		else: if abs(key.position.y-trap.position.y)<70:
			onKeyBrocken()
		state = "none"
	else: if state == "none" and key:
		if key.position.y < 450: key.position.y += 30
		else: key.position.y = 450

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed(): 
			state = "down"
		else: state = "up"

func onKeySuccess():
	print("SUCCESS!")
	key_index += 1
	if(key_index <= max_keys):
		key = get_node("keys/k"+str(key_index))
		trap = get_node("keys/t"+str(key_index))
	else:
		print("SUCCESS ALL LOCS!!!")
		set_process(false)
		$btn_back.text = "EXITO!"

func onKeyBrocken():
	print("BROKEN")
	gan -= 1
	if gan <= 0: 
		$Label.text = "Sin Ganzuas!"
	else:
		$Label.text = "Ganzuas: "+str(gan)

func onClick(arg):
	if arg=="back": endMinigame()
