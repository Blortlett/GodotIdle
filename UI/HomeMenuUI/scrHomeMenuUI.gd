class_name HomeMenu extends Control;
# Button name list
var ButtonNames: Array[String] = ["Craft", "Store", "Explore"]
# Button storage
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];
# Button Spawnable
@onready var mButton: PackedScene = preload("res://UI/ButtonUI/nButtonUI.tscn");

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")

# create buttons on start
func _ready() -> void:
	for i in ButtonNames.size():
		var new_button: Button = mButton.instantiate();
		ButtonParent.add_child(new_button);
		new_button.text = ButtonNames[i];

func OnButtonExplore():
	mGameStateManager.SwapToDestinationMenuState();
