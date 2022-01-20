extends Node2D

var vertices = 8
var module = 150
var module_dr = 0.98
var state = "reduc-stop"
var cnt
var hits
onready var lb = get_parent().get_node("lb_atk")
var points = [
	Vector2(455,140), Vector2(589,395), Vector2(250,321),
	Vector2(525,278), Vector2(705,333), Vector2(435,492),
]
signal end_atack

# Called when the node enters the scene tree for the first time.
func _ready():
	lb.text = ""

func start_atack():
	cnt = 3	
	hits = 0
	updateHitLabel()
	repos_circle()

func stop_atack():
	position = -1*GC.screen
	lb.text = ""
	emit_signal("end_atack",hits)

func _process(delta):
	if state=="reduc": 
		update_circle()
		module *= module_dr
		if module<50: module_dr = 1.02
		if module>150: module_dr = 0.98

func repos_circle():
	if cnt < 1: 
		stop_atack()
		return
	cnt -= 1
	module = 160
	state="reduc"
	$line.default_color = Color(0,0,1,1)
	$base.default_color = Color(1,0,0,1)
	position = points[ randi() % points.size() ]
	Vector2(rand_range(100,GC.screen.x-100), rand_range(80,320))

func update_circle():
	var ver_line = []
	var ver_base = []
	for i in range(vertices+1):
		var x = cos( PI * 2 * 1 / vertices * i )
		var y = sin( PI * 2 * 1 / vertices * i )
		ver_line.append( Vector2(x*module,y*module) )
		ver_base.append( Vector2(x*(150-module),y*(150-module)) )
	$line.points = ver_line
	$base.points = ver_base
	$line.rotation += .1
	$base.rotation += .1

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed(): 
			if state=="reduc": stop_circles()

func stop_circles():
	state="stop"
	if abs( module - (150-module) ) < 5: success()
	else: fail()
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,1),Color(1,1,1,0),1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	modulate = Color(1,1,1,1)
	repos_circle()

func success():
	hits += 1
	updateHitLabel()
	$line.default_color = Color(0,1,0,1)
	$base.default_color = Color(0,1,0,1)
	module = 150/2
	update_circle()

func updateHitLabel():
	lb.text = "Ataque ( "+str(GC.getPjDamage())+" x "+str(hits)+" )"

func fail():
	print("FAIL")
