extends Node2D

var list
var state = "showing-end"

func _ready():
	randomize()
	for i in range(4): 
		var btn = get_node("b"+str(i+1))
		btn.modulate = Color(.2,.2,.2,.5)
		(btn as Button).connect("button_down",self,"onClick",[btn,i+1])

func start_defense():
	list = []
	$Result.text = ""
	state = "showing"
	for i in range(4): list.append(floor( rand_range(1,5)) )
	yield(get_tree().create_timer(1),"timeout")
	show_sequence()

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
		if list.size() == 0: 
			$Result.text = "SUCCESS!"
			print("SUCCESS!")
	else:
		list = []
		$Result.text = "FAIL!"
		print("FAIL!!")

func animate(btn):
	btn.modulate = Color(1,0,0,1)
	$Tween.interpolate_property(btn,"modulate",Color(1,.1,.1,1),Color(.2,.2,.2,.5),.7,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
