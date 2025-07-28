class_name CharacterDisplayController extends Node;
@export var PlayerDisplay: CharacterDisplay;
@export var EnemyDisplay: CharacterDisplay;
@onready var mCharacterRegister: CharacterRegister = get_tree().get_root().get_node("Node/CharacterRegister");

# -= Character Displays =-
func SetPlayerUI(_Character: Character):
	PlayerDisplay.SetCharacter(_Character);

func SetEnemyUI(_Character: Character):
	EnemyDisplay.SetCharacter(_Character);

func UpdateCharacterHealthVisuals():
	UpdatePlayerHealthVisual();
	var EnemyHealthPercent: float;
	EnemyHealthPercent = mCharacterRegister.mActiveEnemyCharacter.CurrentHealth / mCharacterRegister.mActiveEnemyCharacter.Health;
	EnemyDisplay.UpdateHealth(EnemyHealthPercent);

func UpdatePlayerHealthVisual():
	var PlayerHealthPercent: float;
	PlayerHealthPercent = mCharacterRegister.mActiveCharacter.CurrentHealth / mCharacterRegister.mActiveCharacter.Health;
	PlayerDisplay.UpdateHealth(PlayerHealthPercent);
