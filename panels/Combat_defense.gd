extends Node2D

var list
var cnt = 6
var state = "showing-end"
signal end_defense

func _ready():
	randomize()
	modulate.a = 0
	$lb.text = ""
	for i in range(4): 
		var btn = get_node("b"+str(i+1))
		btn.modulate = Color(.2,.2,.2,.5)
		(btn as Button).connect("button_down",self,"onClick",[btn,i+1])

func start_defense():
	list = []
	state = "showing"
	for i in range(cnt): list.append(floor( rand_range(1,5)) )
	$lb.text = "x"+str(list.size())
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,0),Color(1,1,1,1),.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	yield(get_tree().create_timer(.5),"timeout")
	show_sequence()

func stop_defense():
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,1),Color(1,1,1,0),.7,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
#	yield($Tween,"tween_all_completed")
	yield(get_tree().create_timer(.3),"timeout")
	$lb.text = ""
	emit_signal("end_defense", list.size())
	list = []

func show_sequence():
	print(list)
	for i in list:
		var btn = get_node("b"+str(i))
		animate(btn)
		yield($Tween,"tween_all_completed")
	state = "end"

func onClick(btn,i):
	if state != "end": return
	if list.size() == 0: return
	if i == list.pop_front(): 
		animate(btn)
		$lb.text = "x"+str(list.size())
		if list.size() == 0: stop_defense()
	else: 
		list.append(i)
		stop_defense()

func animate(btn):
	btn.modulate = Color(1,0,0,1)
	$Tween.interpolate_property(btn,"modulate",Color(1,.1,.1,1),Color(.2,.2,.2,.5),.7,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
