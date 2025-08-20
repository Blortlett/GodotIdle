class_name SellTimerLabel extends Node
@onready var SellTimerText: Label = get_node("Label")

func _ready() -> void:
	self.visible = false;
	SellTimerText.text = "0s"
