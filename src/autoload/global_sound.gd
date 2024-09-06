extends Node2D


@onready var snd_click: AudioStreamPlayer2D = $snd_click
@onready var snd_success: AudioStreamPlayer2D = $snd_success
@onready var snd_gameover: AudioStreamPlayer2D = $snd_gameover
@onready var snd_pick: AudioStreamPlayer2D = $snd_pick
@onready var snd_put: AudioStreamPlayer2D = $snd_put

var is_muted = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_muted(val):
	is_muted = val
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, is_muted) # or false
