extends Node

class_name CombatManager;

@onready var mCharacterRegister: CharacterRegister = $CharacterRegister;

var IsCombatPossible: bool = false;
var IsCombatActive: bool = false;

var PlayerAttackTimer: float;
var EnemyAttackTimer: float;

func _process(delta):
	if IsCombatActive:
		PlayerAttackTimer -= delta
		EnemyAttackTimer -= delta
		if PlayerAttackTimer <= 0:
			# Player attack here
			ApplyAttackDamage(mCharacterRegister.mActiveCharacter, mCharacterRegister.mActiveEnemyCharacter)
			# Reset Player attack timer
			PlayerAttackTimer = mCharacterRegister.mActiveCharacter.AttackSpeed;
		if EnemyAttackTimer <= 0:
			#Enemy attack here
			ApplyAttackDamage(mCharacterRegister.mActiveCharacter, mCharacterRegister.mActiveEnemyCharacter)
			# Reset Enemy attack timer
			EnemyAttackTimer = mCharacterRegister.mActiveEnemyCharacter.AttackSpeed;


func ApplyAttackDamage(Attacker: Character, Defender: Character):
	#Calculate Damage
	var AttackDamage = Attacker.Damage - Defender.Defense;
	var MagicDamage = Attacker.MagicDamage - Defender.MagicDefense;
	#Apply Damage
	if AttackDamage < 0:
		Defender.CurrentHealth -= AttackDamage;
	if MagicDamage < 0:
		Defender.CurrentHealth -= MagicDamage;
	#Check if defender is dead
