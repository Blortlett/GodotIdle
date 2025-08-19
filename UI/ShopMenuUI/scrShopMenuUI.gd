class_name ShopMenuUI extends Control
@onready var mButtonParent = get_node("ButtonParent")
# Button Spawnable
@onready var mButton: Control = get_node("Button");
#Game manager object ref
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")

func _ready() -> void:
	ImplementButton(mButton);

func ReturnHome():
	mGameStateManager.SwapToHomeState()

func ImplementButton(_Button):
	_Button.pressed.connect(ReturnHome)
