class_name ItemDrag

signal drag_completed(data:ItemDrag)

var source: Control = null
var destination: Control = null

var number: int
var operator : String = "+"
var preview: Control

func _init(_source: Control,  _number: int = 0, _operator : String = ""):
	self.source = _source
	self.number = _number
	self.operator = _operator
	self.preview = source.duplicate()
	self.preview.tree_exiting.connect(_on_tree_exiting)

func _on_tree_exiting()->void:
	drag_completed.emit(self)
