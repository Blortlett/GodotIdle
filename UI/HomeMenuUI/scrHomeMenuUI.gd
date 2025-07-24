extends Control

class_name HomeMenu
var ButtonName: String = "Explore";
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];

@onready var mButton: PackedScene = preload("res://UI/ButtonUI/nButtonUI.tscn");

func _ready() -> void:
	var new_button: Button = mButton.instantiate();
	ButtonParent.add_child(new_button);
	new_button.text = ButtonName;
