extends Node

class_name CombatManager;

# Player healing
var CharacterHealValue: float = 1;
var CharacterHealTimerMax: float = 1;
var CharacterHealCurrentTimer: float = CharacterHealTimerMax;

@onready var mCharacterRegister: CharacterRegister = get_node("../CharacterRegister");
@onready var mInventoryUI: InventoryUI = get_node("../InventoryUI");
@onready var mCharacterDisplayController: CharacterDisplayController = get_node("../InventoryUI/CharacterDisplayController");

var IsCombatActive: bool = false;
# Attack cooldown
var PlayerAttackTimer: float;
var EnemyAttackTimer: float;

# On tick
func _process(delta):
	# Heal player timer always runs
	CharacterHealCurrentTimer -= delta;
	if CharacterHealCurrentTimer <= 0:
		# Heal player & apply health cap
		var PlayerCharacter = mCharacterRegister.mActiveCharacter;
		PlayerCharacter.CurrentHealth += CharacterHealValue;
		if (PlayerCharacter.CurrentHealth > PlayerCharacter.Health):
			PlayerCharacter.CurrentHealth = PlayerCharacter.Health;
		#update health visual
		mCharacterDisplayController.UpdatePlayerHealthVisual();

		#reset timer
		CharacterHealCurrentTimer = CharacterHealTimerMax;
	
	# Run combat loop if combat is active
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
	mCharacterDisplayController.UpdateCharacterHealthVisuals();
	
	if (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth <= 0):
		var Loot: InvItem = mCharacterRegister.KillEnemy();
		mInventoryUI.inv.insert(Loot);
		mInventoryUI.EnemyDisplay.PlayDeathAnimation();
		EndCombat();
	
	if (mCharacterRegister.mActiveCharacter.CurrentHealth <= 0):
		mInventoryUI.PlayerDisplay.PlayDeathAnimation();
		EndCombat();


func BeginCombat():
	IsCombatActive = true;

func EndCombat():
	IsCombatActive = false;
