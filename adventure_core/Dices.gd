extends Control

var runing = 0
var ability_name = "SIGILO"
var ability_bonif = 2
var dificult = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.DICES = self
	randomize()
	visible = false
	$Panel/Button.connect("button_down",self,"run_dices")
	$Panel/btn_back.connect("button_down",self,"close_dices")
#	show_dices("SIGILIO",10,+3)

func _process(delta):
	if runing <= 0: return
	runing -= delta
	var d1 = randi()%6+1
	var d2 = randi()%6+1
	$Panel/lb_result.text = "["+str(d1)+"]+["+str(d2)+"]+"+str(ability_bonif)+" = "+str(d1+d2+ability_bonif)

func show_dices(ab_name,dif,ab_bon):
	ability_name = ab_name
	dificult = dif
	ability_bonif = ab_bon
	$Panel/lb_ability.text = ability_name
	$Panel/lb_dificult.text = str(dificult)
	$Panel/lb_result.text = "[?]+[?]+"+str(ability_bonif)+" = ??"
	visible = true
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func run_dices():
	runing = 2

func close_dices():
	visible = false
