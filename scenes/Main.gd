extends Control

var active = true

func _ready():
	for btn in $VBox.get_children():
		btn.connect("button_down",self,"onClick",[btn])
	$Eye/AnimationPlayer.play("idle")
	$Fade.fadeOut()

func onClick(btn):
	if !active: return
	active = false
	$Fade.fadeIn(.5)
	GC.add_click_fx(btn)
	yield(get_tree().create_timer(.5),"timeout")
	if btn.name=="btn_start": get_tree().change_scene("res://adventure_core/Adventure.tscn")
	if btn.name=="btn_combat": GC.start_combat("combat_001")
	if btn.name=="btn_quit": get_tree().quit()
#	if arg=="locks": GC.startMinigame("locks")
#	if arg=="adventure": 
#	if arg=="combat": 
#		GC.pj_weapon = "hand"
#		GC.startMinigame("combat")
#	if arg=="combat2": 
#		GC.pj_weapon = "sword"
#		GC.startMinigame("combat")
