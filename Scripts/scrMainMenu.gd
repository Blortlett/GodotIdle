class_name MainMenu extends Node
@onready var PlayButton: Button = $PlayButton
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
@onready var mUIController: UIController = get_tree().get_root().get_node("Node/UIController")

func _ready() -> void:
	PlayButton.button_up.connect(Play)

func Play():
	print("GameStart")
	mUIController.StartGame()
	mGameStateManager.SwapToHomeState()
