extends PathFollow2D

export var runSpeed = 500
var timer = 0
var start = 0

func gameOn():
	start = 1

func gameOver():
	hide()


func _process(delta):
	runSpeed += delta * 2
	if start == 1:
		set_offset(get_offset() + runSpeed * delta)
