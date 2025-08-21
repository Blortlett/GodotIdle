class_name PlayerData extends Node
var mPlayerMoney: int = 0;
var mEnemiesKilled: int = 0;
# Player money balance display
@onready var mPlayerMoneyDisplay: Label = get_tree().get_root().get_node("Node/GameUI/SystemUI/CharacterUI/PlayerMoneyLabel")
@onready var mEnemyKillCountDisplay: Label = get_tree().get_root().get_node("Node/GameUI/SystemUI/CombatMenuUI/EnemiesKilledLabel")
@onready var mCombatManager: CombatManager = get_tree().get_root().get_node("Node/CombatManager")

func _ready() -> void:
	RefreshPlayerMoneyDisplay()
	RefreshEnemyKillCountDisplay()
	mCombatManager.EnemyDeath.connect(OnEnemyKilled)

func AddMoney(_MoneyToAdd: int):
	mPlayerMoney += _MoneyToAdd;
	RefreshPlayerMoneyDisplay()

func OnEnemyKilled():
	mEnemiesKilled += 1;
	RefreshEnemyKillCountDisplay()

func RefreshEnemyKillCountDisplay():
	mEnemyKillCountDisplay.text = str(mEnemiesKilled)

func RefreshPlayerMoneyDisplay():
	mPlayerMoneyDisplay.text = "$"+str(mPlayerMoney)
