extends Node2D

func _ready():
	$btn_start.connect("button_down",self,"onClick",["start"])
	$btn_quit.connect("button_down",self,"onClick",["quit"])
	$btn_locks.connect("button_down",self,"onClick",["locks"])
	$Eye/AnimationPlayer.play("idle")
	$ClickArea.connect("onClickArea",self,"onClickArea")

func onClick(arg):
	if arg=="start": get_tree().change_scene("res://rooms/prologo.tscn")
	if arg=="quit": get_tree().quit()
	if arg=="locks": $Locks.startMinigame()

func onClickArea(arg):
	print(arg)
