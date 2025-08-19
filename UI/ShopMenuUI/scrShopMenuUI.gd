class_name ShopMenuUI extends Control
@onready var mButtonParent = get_node("ButtonParent")
# Button Spawnable
@onready var mButton: PackedScene = preload("res://UI/ButtonUI/nButtonUI.tscn");
#Game manager object ref
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")

func _ready() -> void:
	var new_button: Button = mButton.instantiate();
	mButtonParent.add_child(new_button);
	new_button.text = "Home";
	ImplementButton(new_button);

func ReturnHome():
	mGameStateManager.SwapToHomeState()

func ImplementButton(_Button):
	_Button.pressed.connect(ReturnHome)
