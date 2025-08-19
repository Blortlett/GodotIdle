class_name PlayerData extends Node
var mPlayerMoney: int = 0;
# Player money balance display
@onready var mPlayerMoneyDisplay: Label = get_tree().get_root().get_node("Node/GameUI/SystemUI/CharacterUI/PlayerMoneyLabel")

func _ready() -> void:
	RefreshPlayerMoneyDisplay()

func AddMoney(_MoneyToAdd: int):
	mPlayerMoney += _MoneyToAdd;
	RefreshPlayerMoneyDisplay()

func RefreshPlayerMoneyDisplay():
	mPlayerMoneyDisplay.text = "$"+str(mPlayerMoney)
