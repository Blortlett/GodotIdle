extends Control

class_name CharacterDisplay;

var IsDisplaying: bool = false;
var CurrentCharacter: Character;

@export var CreatureSpriteDisplay: Control;
@export var CreatureInfoPanel: Control;
@export var DisplaySprite: AnimatedSprite2D;
@export var CreatureNameDisplay: Label;
@export var CreatureHealthDisplay: TextureProgressBar;
@export var IsPlayerDisplay: bool;

@onready var mCharacterRegister: CharacterRegister = get_tree().get_root().get_node("Node/CharacterRegister") 

func _ready() -> void:
	if !IsPlayerDisplay:
		mCharacterRegister.NewEnemySpawn.connect(OnEnemyRespawn);
	DisplaySprite.animation_finished.connect(SwapToIdleAnimation);
	# if player display, flip it to face enemy character
	if (IsPlayerDisplay):
		DisplaySprite.scale.x = -2;

func SetCharacter(_Character: Character) -> void:
	CurrentCharacter = _Character;
	DisplaySprite.sprite_frames = _Character.Sprite;
	DisplaySprite.play("Idle");
	CreatureNameDisplay.text = _Character.Name;
	CreatureHealthDisplay.value = (_Character.CurrentHealth / _Character.Health) * 100;

func UpdateHealth(_PercentValue: float):
	CreatureHealthDisplay.value = _PercentValue;

func PlayAttackAnimation():
	var HeavyAttack = randi_range(0, 1);
	if (HeavyAttack == 1):
		DisplaySprite.play("Attack2");
	else:
		DisplaySprite.play("Attack1");

func PlayDeathAnimation():
	DisplaySprite.play("Die");

func StopAnimation():
	DisplaySprite.pause();

func SwapToIdleAnimation():
	if (DisplaySprite.animation != "Die"):
		DisplaySprite.play("Idle");

func OnEnemyRespawn():
	DisplaySprite.sprite_frames = mCharacterRegister.mActiveEnemyCharacter.Sprite;
	CreatureNameDisplay.text = mCharacterRegister.mActiveEnemyCharacter.Name;
	CreatureHealthDisplay.value = (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth / mCharacterRegister.mActiveEnemyCharacter.Health) * 100;
