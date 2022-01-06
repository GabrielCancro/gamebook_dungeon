extends Node2D

var vertices = 8
var module = 150
var module_dr = 0.98
var state = "reduc-stop"
var wins = 0
var lost = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_back.connect("button_down",self,"onClick",["back"])
	randomize()

func startMinigame():
	set_process(true)
	visible = true
	$Label.text = "COMBATE!"
	$btn_back.text = "Desistir"
#	repos_circle()
	$defense.start_defense()

func endMinigame():
	set_process(false)
	visible = false

func onClick(arg):
	if arg=="back": endMinigame()

func _process(delta):
	if state=="reduc": 
		update_circle()
		module *= module_dr
		if module<50: module_dr = 1.02
		if module>150: module_dr = 0.98

func repos_circle():
	module = 160
	state="reduc"
	$point/line.default_color = Color(0,0,1,1)
	$point/base.default_color = Color(1,0,0,1)
	$point.position = Vector2(rand_range(100,GC.screen.x-100), rand_range(80,320))

func update_circle():
	var ver_line = []
	var ver_base = []
	for i in range(vertices+1):
		var x = cos( PI * 2 * 1 / vertices * i )
		var y = sin( PI * 2 * 1 / vertices * i )
		ver_line.append( Vector2(x*module,y*module) )
		ver_base.append( Vector2(x*(150-module),y*(150-module)) )
	$point/line.points = ver_line
	$point/base.points = ver_base
	$point.rotation += .1

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed(): 
			if state=="reduc": stop_circles()
				

func stop_circles():
	state="stop"
	if abs( module - (150-module) ) < 5: success()
	else: fail()
	$point/Tween.interpolate_property($point,"modulate",Color(1,1,1,1),Color(1,1,1,0),1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$point/Tween.start()
	yield($point/Tween, "tween_all_completed")
	$point.modulate = Color(1,1,1,1)
	repos_circle()

func success():
	wins += 1
	$point/line.default_color = Color(0,1,0,1)
	$point/base.default_color = Color(0,1,0,1)
	$Label.text = "W"+str(wins)+"   L"+str(lost)
	module = 150/2
	update_circle()

func fail():
	lost += 1
	$Label.text = "W"+str(wins)+"   L"+str(lost)
