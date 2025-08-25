class_name CharacterDisplayController extends Node;
@export var PlayerDisplay: CharacterDisplay;
@export var EnemyDisplay: CharacterDisplay;
@onready var mCharacterRegister: CharacterRegister = get_tree().get_root().get_node("Node/CharacterRegister");
@onready var mPlayerDmgNumCtrl: DamageNumberController = PlayerDisplay.mDamageNumberControl;
@onready var mEnemyDmgNumCtrl: DamageNumberController = EnemyDisplay.mDamageNumberControl;

@export var mPlayerCharacterAnimations: Array[SpriteFrames];

# -= Character Displays =-
func SetPlayerUI(_Character: Character):
	PlayerDisplay.SetCharacter(_Character);

func SetEnemyUI(_Character: Character):
	EnemyDisplay.SetCharacter(_Character);

func SetPlayerCharacterSpriteFromWeaponType(_CombatType: InvItem.CombatType):
	match _CombatType:
		InvItem.CombatType.MAGIC:
			PlayerDisplay.DisplaySprite.sprite_frames = mPlayerCharacterAnimations[0]
			PlayerDisplay.CreatureNameDisplay.text = mCharacterRegister.mPlayerCharacters[0].Name
		InvItem.CombatType.RANGED:
			PlayerDisplay.DisplaySprite.sprite_frames = mPlayerCharacterAnimations[1]
			PlayerDisplay.CreatureNameDisplay.text = mCharacterRegister.mPlayerCharacters[1].Name
		InvItem.CombatType.MELEE:
			PlayerDisplay.DisplaySprite.sprite_frames = mPlayerCharacterAnimations[2]
			PlayerDisplay.CreatureNameDisplay.text = mCharacterRegister.mPlayerCharacters[2].Name
	PlayerDisplay.OnPlayerArriveHome(); #Janky way to swap to idle

func UpdateCharacterHealthVisuals():
	UpdatePlayerHealthVisual();
	var EnemyHealthPercent: float;
	EnemyHealthPercent = (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth / mCharacterRegister.mActiveEnemyCharacter.Health) * 100;
	EnemyDisplay.UpdateHealth(EnemyHealthPercent);

func UpdatePlayerHealthVisual():
	var PlayerHealthPercent: float;
	PlayerHealthPercent = (mCharacterRegister.mActiveCharacter.CurrentHealth / mCharacterRegister.mActiveCharacter.Health) * 100;
	PlayerDisplay.UpdateHealth(PlayerHealthPercent);
