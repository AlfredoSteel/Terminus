extends Node

var select = null
var player_camera = null
	
func rand_curve():
	return pow(randf(), 6)

func variation(percent_margin : float):
	return pow(2 * (randf() - .5), 5) * percent_margin + 1

func basic_tween():
	var uwu = get_tree().create_tween().set_parallel(true)
	uwu.set_ease(Tween.EASE_OUT)
	uwu.set_trans(Tween.TRANS_EXPO)
	return uwu
	
func treat_angles(angle):
	if angle < 0:
		angle = 2 * PI + angle
	return(fmod(angle, TAU))
