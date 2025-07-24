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

func _ready() -> void:
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
	print_debug("Updated Health Display!: " + str(_PercentValue));

func StopAnimation():
	DisplaySprite.pause();
