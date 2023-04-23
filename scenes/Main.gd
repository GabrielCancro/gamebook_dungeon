extends Node2D

func _ready():
	$VBox/btn_start.connect("button_down",self,"onClick",["start"])
	$VBox/btn_quit.connect("button_down",self,"onClick",["quit"])
	$VBox/btn_locks.connect("button_down",self,"onClick",["locks"])
	$VBox/btn_combat.connect("button_down",self,"onClick",["combat"])
	$VBox/btn_combat2.connect("button_down",self,"onClick",["combat2"])
	$VBox/btn_adventure.connect("button_down",self,"onClick",["adventure"])
	$Eye/AnimationPlayer.play("idle")

func onClick(arg):
	if arg=="start": get_tree().change_scene("res://rooms/prologo.tscn")
	if arg=="quit": get_tree().quit()
	if arg=="locks": GC.startMinigame("locks")
	if arg=="adventure": get_tree().change_scene("res://scenes/Adventure.tscn")	
	if arg=="combat": 
		GC.pj_weapon = "hand"
		GC.startMinigame("combat")
	if arg=="combat2": 
		GC.pj_weapon = "sword"
		GC.startMinigame("combat")

func onClickArea(arg):
	print(arg)
