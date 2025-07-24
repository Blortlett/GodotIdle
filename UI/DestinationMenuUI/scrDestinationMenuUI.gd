extends Control

class_name DestinationMenu;
@export var Destinations: Array[ExplorableArea];
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];

@onready var mButton: PackedScene = preload("res://UI/ButtonUI/nButtonUI.tscn");

func _ready() -> void:
	for i in Destinations.size():
		var new_button: Button = mButton.instantiate();
		ButtonParent.add_child(new_button);
		new_button.text = Destinations[i].Name;
