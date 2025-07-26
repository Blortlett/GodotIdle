extends Node

class_name CombatManager;

# Player healing
var CharacterHealValue: float = 1;
var CharacterHealTimerMax: float = 1;
var CharacterHealCurrentTimer: float = CharacterHealTimerMax;

@onready var mCharacterRegister: CharacterRegister = get_node("../CharacterRegister");
@onready var mInventoryUI: InventoryUI = get_node("../GameUI");
@onready var mCharacterDisplayController: CharacterDisplayController = get_node("../GameUI/CharacterDisplayController");

var IsCombatActive: bool = false;
# Attack cooldown
var PlayerAttackTimer: float;
var EnemyAttackTimer: float;

# On tick
func _process(delta):
	# Heal player timer always runs
	CharacterHealCurrentTimer -= delta;
	HealPlayerTick();
	
	# Run combat loop if combat is active
	if IsCombatActive:
		PlayerAttackTimer -= delta
		EnemyAttackTimer -= delta
		if PlayerAttackTimer <= 0:
			_PlayerAttackTick()
		if EnemyAttackTimer <= 0:
			_EnemyAttackTick();

func _PlayerAttackTick():
	# Player attack here
			mCharacterDisplayController.PlayerDisplay.PlayAttackAnimation();
			ApplyAttackDamage(mCharacterRegister.mActiveCharacter, mCharacterRegister.mActiveEnemyCharacter)
			# Reset Player attack timer
			PlayerAttackTimer = mCharacterRegister.mActiveCharacter.AttackSpeed;

func _EnemyAttackTick():
	#Enemy attack here
			mCharacterDisplayController.EnemyDisplay.PlayAttackAnimation();
			ApplyAttackDamage(mCharacterRegister.mActiveEnemyCharacter, mCharacterRegister.mActiveCharacter)
			# Reset Enemy attack timer
			EnemyAttackTimer = mCharacterRegister.mActiveEnemyCharacter.AttackSpeed;

func HealPlayerTick():
	if CharacterHealCurrentTimer <= 0:
		# Heal player & apply health cap
		var PlayerCharacter = mCharacterRegister.mActiveCharacter;
		PlayerCharacter.CurrentHealth += CharacterHealValue;
		if (PlayerCharacter.CurrentHealth > PlayerCharacter.Health):
			PlayerCharacter.CurrentHealth = PlayerCharacter.Health;
		#update health visual
		mCharacterDisplayController.UpdatePlayerHealthVisual();
		#reset heal timer
		CharacterHealCurrentTimer = CharacterHealTimerMax;

func ApplyAttackDamage(Attacker: Character, Defender: Character):
	var AttackerDamage: float;
	var DefenderPower: float;
	# Get Attack Power
	if Attacker.mPlayerType == Character.PlayerType.PLAYER:
		AttackerDamage = _GetPlayerDamageOutput();
	else:
		AttackerDamage = _GetNPCDamageOutput();
	#Get Defense Power
	if Defender.mPlayerType == Character.PlayerType.PLAYER:
		DefenderPower = _GetPlayerDefense();
	else:
		DefenderPower = _GetNPCDefense();
		
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
	
	# Enemy Death
	if (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth <= 0):
		var Loot: InvItem = mCharacterRegister.KillEnemy();
		mInventoryUI.inv.insert(Loot); # Drop Loot
		mCharacterDisplayController.EnemyDisplay.PlayDeathAnimation();
		EndCombat();
	# Player Death
	if (mCharacterRegister.mActiveCharacter.CurrentHealth <= 0):
		mCharacterDisplayController.PlayerDisplay.PlayDeathAnimation();
		EndCombat();

func _GetPlayerDamageOutput() -> float:
	var TotalDamage: float = 0;
	return TotalDamage;

func _GetPlayerDefense() -> float:
	var TotalDefense: float = 0;
	return TotalDefense;
	
func _GetNPCDamageOutput() -> float:
		var TotalDamage: float = 0;
		return TotalDamage;

func _GetNPCDefense() -> float:
	var TotalDefense: float = 0;
	return TotalDefense;

func BeginCombat():
	IsCombatActive = true;

func EndCombat():
	IsCombatActive = false;
