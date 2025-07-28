class_name CharacterDisplayController extends Node;
@export var PlayerDisplay: CharacterDisplay;
@export var EnemyDisplay: CharacterDisplay;
@onready var mCharacterRegister: CharacterRegister = get_tree().get_root().get_node("Node/CharacterRegister");
@onready var mPlayerDmgNumCtrl: DamageNumberController = PlayerDisplay.mDamageNumberControl;
@onready var mEnemyDmgNumCtrl: DamageNumberController = EnemyDisplay.mDamageNumberControl;

# -= Character Displays =-
func SetPlayerUI(_Character: Character):
	PlayerDisplay.SetCharacter(_Character);

func SetEnemyUI(_Character: Character):
	EnemyDisplay.SetCharacter(_Character);

func UpdateCharacterHealthVisuals():
	UpdatePlayerHealthVisual();
	var EnemyHealthPercent: float;
	EnemyHealthPercent = (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth / mCharacterRegister.mActiveEnemyCharacter.Health) * 100;
	EnemyDisplay.UpdateHealth(EnemyHealthPercent);

func UpdatePlayerHealthVisual():
	var PlayerHealthPercent: float;
	PlayerHealthPercent = (mCharacterRegister.mActiveCharacter.CurrentHealth / mCharacterRegister.mActiveCharacter.Health) * 100;
	PlayerDisplay.UpdateHealth(PlayerHealthPercent);
