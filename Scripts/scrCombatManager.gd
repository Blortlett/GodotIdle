extends Node

class_name CombatManager;

@onready var mCharacterRegister: CharacterRegister = get_node("../CharacterRegister");
@onready var mInventoryUI: InventoryUI = get_node("../InventoryUI");

var IsCombatActive: bool = false;
# Attack cooldown
var PlayerAttackTimer: float;
var EnemyAttackTimer: float;

# On tick
func _process(delta):
	if IsCombatActive:
		PlayerAttackTimer -= delta
		EnemyAttackTimer -= delta
		if PlayerAttackTimer <= 0:
			# Player attack here
			mInventoryUI.PlayerDisplay.PlayAttackAnimation();
			ApplyAttackDamage(mCharacterRegister.mActiveCharacter, mCharacterRegister.mActiveEnemyCharacter)
			# Reset Player attack timer
			PlayerAttackTimer = mCharacterRegister.mActiveCharacter.AttackSpeed;
		if EnemyAttackTimer <= 0:
			#Enemy attack here
			mInventoryUI.EnemyDisplay.PlayAttackAnimation();
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
	
	if (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth <= 0):
		var Loot: InvItem = mCharacterRegister.KillEnemy();
		mInventoryUI.inv.insert(Loot);
		mInventoryUI.EnemyDisplay.StopAnimation();
		EndCombat();
	
	if (mCharacterRegister.mActiveCharacter.CurrentHealth <= 0):
		EndCombat();


func BeginCombat():
	IsCombatActive = true;

func EndCombat():
	IsCombatActive = false;
