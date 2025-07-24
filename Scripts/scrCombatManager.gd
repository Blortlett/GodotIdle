extends Node

class_name CombatManager;

@onready var mCharacterRegister: CharacterRegister = get_node("../CharacterRegister");
@onready var mInventoryUI: InventoryUI = get_node("../InventoryUI");

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
			ApplyAttackDamage(mCharacterRegister.mActiveEnemyCharacter, mCharacterRegister.mActiveCharacter)
			# Reset Enemy attack timer
			EnemyAttackTimer = mCharacterRegister.mActiveEnemyCharacter.AttackSpeed;
func ApplyAttackDamage(Attacker: Character, Defender: Character):
	#Calculate Damage
	var AttackDamage = Attacker.Damage - Defender.Defense;
	var MagicDamage = Attacker.MagicDamage - Defender.MagicDefense;
	#Apply Damage
	if AttackDamage > 0:
		Defender.CurrentHealth -= AttackDamage;
	if MagicDamage > 0:
		Defender.CurrentHealth -= MagicDamage;
		
	#Update Health UI
	var PlayerHealthPercent = (mCharacterRegister.mActiveCharacter.CurrentHealth / mCharacterRegister.mActiveCharacter.Health) * 100;
	var EnemyHealthPercent = (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth / mCharacterRegister.mActiveEnemyCharacter.Health) * 100;
	mInventoryUI.UpdateCharacterHealthVisuals(PlayerHealthPercent, EnemyHealthPercent);
	
	#Debug output
	print_debug(Attacker.Name + " Atttacked " + Defender.Name + " for " + str(AttackDamage + MagicDamage) + " damage!");

func BeginCombat():
	IsCombatActive = true;
