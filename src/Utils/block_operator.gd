extends TextureRect
class_name BlockOperator

@export_enum("-", "+", "/", "*") var number = "+"
@onready var display: Label = $Number

func  _ready() -> void:
	set_text(number)

func _get_drag_data(at_position: Vector2) -> Variant:
	var data = number
	var prev = TextureRect.new()
	var drag_data = ItemDrag.new(self, 0, number)
	set_drag_preview(drag_data.preview)
	return self
	

func set_text(content):
	display.text = str(content)
