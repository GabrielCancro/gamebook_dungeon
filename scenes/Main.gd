extends Control

func _ready():
	for btn in $VBox.get_children():
		btn.connect("button_down",self,"onClick",[btn.name])
	$Eye/AnimationPlayer.play("idle")

func onClick(btn):
	if btn=="btn_start": get_tree().change_scene("res://adventure_core/Adventure.tscn")
	if btn=="btn_combat": get_tree().change_scene("res://adventure_core/Combat.tscn")
	if btn=="btn_quit": get_tree().quit()
#	if arg=="locks": GC.startMinigame("locks")
#	if arg=="adventure": 
#	if arg=="combat": 
#		GC.pj_weapon = "hand"
#		GC.startMinigame("combat")
#	if arg=="combat2": 
#		GC.pj_weapon = "sword"
#		GC.startMinigame("combat")
