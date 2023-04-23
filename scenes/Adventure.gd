extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Desitions.rect_size.y = $Desitions/NinePatchRect/Options.rect_size.y + 100
	$Desitions.rect_position.y = 1366-$Desitions.rect_size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
