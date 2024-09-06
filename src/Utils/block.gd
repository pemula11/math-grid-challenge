extends TextureRect
class_name Block

@export var number : int = 0
@onready var display: Label = $Number

func  _ready() -> void:
	set_text(number)

func _get_drag_data(at_position: Vector2) -> Variant:
	GlobalSound.snd_pick.play()
	var data = number
	var prev = TextureRect.new()
	var drag_data = ItemDrag.new(self, data)
	set_drag_preview(drag_data.preview)
	return self
	

func set_text(content):
	display.text = str(content)

func generate_number():
	number = randi_range(1,9)
	set_text(number)
