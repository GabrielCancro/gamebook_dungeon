
extends Control

var d1 = 0
var d2 = 0
var duration = 1.2

onready var end_pos1 = $Dice1.position
onready var end_pos2 = $Dice2.position

signal end_roll(val)

func _ready():
	randomize()
	$Timer.connect("timeout",self,"on_time")

func hide_dices():
	visible = false

func hide_dices_with_anim(duration=.2):
	$Tween.remove_all()
	$Tween.interpolate_property(self,"modulate",modulate,Color(1,1,1,0),duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(duration+.2),"timeout")
	hide_dices()
	modulate.a = 1

func on_time():
	d1 = randi()%6+1
	$Dice1.frame = d1-1
	d2 = randi()%6+1
	$Dice2.frame = d2-1

func roll(orgY=120,desX=60):
	$Tween.remove_all()
	var start_pos1 = end_pos1 + Vector2(-desX,orgY)
	add_dice_anim($Dice1,start_pos1,end_pos1)
	var start_pos2 = end_pos2 + Vector2(desX,orgY)
	add_dice_anim($Dice2,start_pos2,end_pos2)
	$Tween.start()
	$Timer.start()
	visible = true
	
	yield(get_tree().create_timer(1),"timeout")
	$Timer.stop()
	yield(get_tree().create_timer(1),"timeout")
	emit_signal("end_roll",d1+d2)

func add_dice_anim(dice,start,end):
	var rot = -90-randi()%200
	dice.position = start
	dice.modulate.a = 0
	dice.rotation_degrees = rot
	$Tween.interpolate_property(dice,"position",start,end,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property(dice,"rotation_degrees",rot,0,duration,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property(dice,"modulate",Color(1,1,1,0),Color(1,1,1,1),duration/3,Tween.TRANS_QUAD,Tween.EASE_OUT)
