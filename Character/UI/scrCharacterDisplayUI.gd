extends Control

class_name CharacterDisplay;

var IsDisplaying: bool = false;
var CurrentCharacter: Character;

@export var CreatureSpriteDisplay: Control;
@export var CreatureInfoPanel: Control;
@export var DisplaySprite: AnimatedSprite2D;
@export var CreatureNameDisplay: Label;


func SetCharacter(_Character: Character) -> void:
	CurrentCharacter = _Character;
	DisplaySprite.sprite_frames = _Character.Sprite;
	CreatureNameDisplay.text = _Character.Name;
