extends Node

var current_scene = "world" # can be equal to world or cliffside
var transition_scene = false

var player_exit_cliffside_posx = 365
var player_exit_cliffside_posy = 1
var player_start_posx = 10
var player_start_posy = 73

var game_first_loadin = true

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
