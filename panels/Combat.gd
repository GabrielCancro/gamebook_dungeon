extends Node2D

var end_combat = false
var enemy_data = {
	"atk": 15,
	"hp": 120
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_back.connect("button_down",self,"onClick",["back"])
	$atack.connect("end_atack",self,"onEndAttack")
	$defense.connect("end_defense",self,"onEndDefense")
	$HPEnemy.connect("empty",self,"onVictory")
	$HPPlayer.connect("empty",self,"onDefeat")
	randomize()

func startMinigame():
	visible = true
	end_combat = false
	$Label.text = "Preparate"
	$btn_back.text = "Desistir"
	$enemy.modulate = Color(1,1,1,1)
	$HPEnemy.init(enemy_data.hp)
	$HPPlayer.init(100)
	$enemy/Tween.interpolate_property($enemy,"modulate",Color(1,1,1,0),Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$enemy/Tween.start()
	onEndDefense(0)

func endMinigame():
	visible = false
	end_combat = true

func onClick(arg):
	if arg=="back": endMinigame()

func onEndAttack(hits):
	if end_combat: return
	$HPEnemy.damage(GC.pj_atk*hits)
	yield($HPEnemy,"end_animation")
	yield(get_tree().create_timer(1),"timeout")
	if end_combat: return
	$Label.text = "Defiendete"
	yield(get_tree().create_timer(.5),"timeout")	
	$defense.start_defense()

func onEndDefense(hits):
	if end_combat: return
	$HPPlayer.damage(enemy_data.atk*hits*0.7)
	yield($HPPlayer,"end_animation")
	yield(get_tree().create_timer(1),"timeout")
	if end_combat: return
	$Label.text = "Tu atacas"
	yield(get_tree().create_timer(.5),"timeout")	
	$atack.start_atack()

func onVictory():
	end_combat = true
	$Label.text = "VICTORIA"
	$enemy/Tween.interpolate_property($enemy,"modulate",Color(1,1,1,1),Color(1,0,0,0),1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$enemy/Tween.start()
	
func onDefeat():
	end_combat = true
	$Label.text = "HAS MUERTO"
