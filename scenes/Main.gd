extends Node2D

func _ready():
	$btn_start.connect("button_down",self,"onClick",["start"])
	$btn_quit.connect("button_down",self,"onClick",["quit"])
	$Eye/AnimationPlayer.play("idle")

func onClick(arg):
	if arg=="start": get_tree().change_scene("res://scenes/Game.tscn")
	if arg=="quit": get_tree().quit()
