extends Node2D

var maxHp
signal end_animation
signal empty

func init(_maxHp):
	maxHp = _maxHp
	$TextureProgress.value = maxHp

func damage(num):
	var endValue = $TextureProgress.value - num
	if endValue < 0: endValue = 0
	else: if endValue > maxHp: endValue = maxHp
	$Tween.interpolate_property($TextureProgress,"value",$TextureProgress.value,endValue,.5,Tween.TRANS_EXPO,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	emit_signal("end_animation")
	if $TextureProgress.value <= 0: emit_signal("empty")
