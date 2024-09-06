extends Control

var data = {
	1 : {"block" : "", "condition": false},
	2 : {"block" : "", "condition": false},
	3 : {"block" : "", "condition": false},
	4 : {"block" : "", "condition": false},
	5 : {"block" : "", "condition": false},
	6 : {"block" : "", "condition": false},
	7 : {"block" : "", "condition": false},
	8 : {"block" : "", "condition": false},
	9 : {"block" : "", "condition": false}
}

var data_jawab = {
	0: {"number": 12},
	1: {"number": 15},
	2: {"number": 10},
	3: {"number": 4}
}

var blocks_answer = []

const combos = [[1,2,3], [1,4,7], [3,6,9], [7,8,9]]

var score = 0
@export var init_time: float = 60.0
var current_time = 0.0
@onready var lbl_score: Label = $Container/VBoxContainer/CenterContainer/HBoxContainer/TextureRect/lblScore
@onready var lbl_time: Label = $Container/VBoxContainer/CenterContainer/HBoxContainer/TextureRect2/Label
@onready var timer: Timer = $Timer
@onready var game_over_panel: PanelContainer = $Container/GameOver
@onready var game_over_score: Label = $Container/GameOver/TextureRect/Label
@onready var toggle_sound: TextureButton = $Container/VBoxContainer/CenterContainer/Control/ToggleSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalSound.is_muted:
		toggle_sound.button_pressed = true
	var block_answer = get_tree().get_nodes_in_group("answerBox")
	for block in block_answer:
		data_jawab[block.idx]["block"] = block 
		block.set_number(data_jawab[block.idx]["number"])
	GlobalManager.connect("on_drop_block", on_drop_box)
	
	for key in data_jawab.keys():
		pass
	
	lbl_score.text = str(score)
	lbl_time.text = str(int(init_time))
	current_time = init_time
	timer.wait_time = init_time
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lbl_time.text = str(int(timer.time_left))

func on_drop_box(_box: Box):
	data[_box.idx]["condition"] = true
	data[_box.idx]["block"] = _box
	check_hasil(find_combo())
	


func  find_combo():
	var filled = []
	for combo in combos:
		
		var fill = true
		for idx in combo:
			
			if data[idx]["condition"] == false:
				fill = false
				break
		
		if fill:
			
			filled.append(combo)
	
	return filled 
	
func check_hasil(array):
	var correct = []
	for phase in array:
		var hasil = []
		for val in phase:
			var box = data[val]["block"]
			if box.type == "number":
				hasil.append(box.number)
			else:
				hasil.append(box.operator)
		
		
		var nilai = hitung(hasil)
		if data_jawab[combos.find(phase)]["number"] == nilai:
			correct.append(combos.find(phase))
	
	if !correct.is_empty():
		print(correct)
		reset_data(correct)
		GlobalSound.snd_success.play()


func  hitung(array):
	var hasil = 0
	if array[1] == "+":
		hasil = array[0] + array[2]
	elif array[1] == "-":
		hasil = array[0] - array[2]
	elif array[1] == "/":
		hasil = array[0] / array[2]
	elif array[1] == "*":
		hasil = array[0] * array[2]
				
	return (hasil)

func reset_data(array):
	
	for idx in array:
		increase_score()
		var new_num = randi_range(1,15)
		data_jawab[idx]["number"] = new_num
		data_jawab[idx]["block"].set_number(new_num)
		var list = combos[idx]
		for i in list:
			data[i]["block"].generate_new()
			data[i]["condition"] = false

func generate_new_answer():
	var data = [1,2,3,4,5,6,7,8,9,10,12,14,15,16,18,20,22,24,25,26,27,28,30]
	return data.pick_random()


func increase_score():
	score += 10
	timer.start(timer.time_left + 5)
	lbl_score.text = str(score)


func _on_timer_timeout() -> void:
	GlobalSound.snd_gameover.play()
	game_over_score.text = str(score)
	game_over_panel.show()


func _on_texture_button_pressed() -> void:
	GlobalSound.snd_click.play()
	get_tree().change_scene_to_file("res://src/scene/home.tscn")


func _on_toggle_sound_toggled(toggled_on: bool) -> void:
	GlobalSound.set_muted(toggled_on)
