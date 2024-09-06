extends TextureRect
class_name  Box

@onready var display_number: Label = $Number
@export_enum("operator", "number", "null") var type = "number"

var number : int = 0
var operator : String = "+"
var is_number : bool = true
@export var isActive = false
@export var canDrop = true
@export var idx : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == "operator":
		is_number = false
		texture = GlobalManager.block_color["red"]
		display_number.text = " "
	elif  type == "number" :
		is_number = true
	else :
		texture = GlobalManager.block_color["white"]


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, _data: Variant) -> void:
	if !canDrop:
		return
	
	var data = _data.number
	var is_int : bool = check_int(data)
	if type == "number" and is_int:
		GlobalSound.snd_put.play(0.7)
		display_number.text = str(data)
		number = data
		texture = GlobalManager.block_color["blue"]
		_data.generate_number()
		GlobalManager.on_drop_block.emit(self)
	elif type == "operator" and !is_int:
		GlobalSound.snd_put.play(0.7)
		display_number.text = str(data)
		operator = data
		texture = GlobalManager.block_color["red"]
		GlobalManager.on_drop_block.emit(self)
	
	

func on_drop(block):
	texture = preload("res://asset/button/4.png")
	
func check_int(_data):
	if typeof(_data) == TYPE_STRING:
		return false
	elif typeof(_data) == TYPE_INT:
		return true

func set_number(num):
	display_number.text = str(num)
	number = num

func generate_new():
	display_number.text = str("")
	number = 0
	if is_number:
		texture = GlobalManager.block_color["grey"]
	else :
		texture = GlobalManager.block_color["red"]
