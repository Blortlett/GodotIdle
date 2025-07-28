extends Node

class_name CombatManager;

# Player healing
var CharacterHealValue: float = 1;
var CharacterHealTimerMax: float = 1;
var CharacterHealCurrentTimer: float = CharacterHealTimerMax;

@onready var mCharacterRegister: CharacterRegister = get_node("../CharacterRegister");
@onready var mInventoryUI: InventoryUI = get_node("../GameUI");
@onready var mCharacterDisplayController: CharacterDisplayController = get_node("../GameUI/CharacterDisplayController");
@onready var mPlayerEquipmentManager: EquipmentManager = get_node("../GameUI/SystemUI/CharacterUI/EquipmentUI");

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
	var AttackerDamage: DamageHit = DamageHit.new();
	var DefenderPower: DefendPower = DefendPower.new();
	# Get Attack Power
	if Attacker.mPlayerType == Character.PlayerType.PLAYER:
		AttackerDamage = _GetPlayerDamageOutput(Attacker);
	else:
		AttackerDamage = _GetNPCDamageOutput(Attacker);
	#Get Defense Power
	if Defender.mPlayerType == Character.PlayerType.PLAYER:
		DefenderPower = _GetPlayerDefense(Defender);
	else:
		DefenderPower = _GetNPCDefense(Defender);
		
	#Calculate Damage
	var AttackDamage = AttackerDamage.PhysicalDamage - DefenderPower.PhysicalDefense;
	var MagicDamage = AttackerDamage.MagicDamage - DefenderPower.MagicDefense;
	
	#Apply Damage
	if AttackDamage > 0:
		Defender.CurrentHealth -= AttackDamage;
	if MagicDamage > 0:
		Defender.CurrentHealth -= MagicDamage;
	
	#Update Health UI
	mCharacterDisplayController.UpdateCharacterHealthVisuals();
	# Check if anyone died
	HandleCharacterDeath();

func _GetPlayerDamageOutput(Player: Character) -> DamageHit:
	var TotalDamage: DamageHit = DamageHit.new();
	var combatModifiers: CombatModifiers = mPlayerEquipmentManager.GetEquipmentModifiers(); # Bad code this runs twice: see _GetPlayerDefense
	TotalDamage.PhysicalDamage += Player.Damage + combatModifiers.DamageModifier;
	TotalDamage.MagicDamage += Player.MagicDamage + combatModifiers.MagicDamageModifier;
	return TotalDamage;

func _GetPlayerDefense(Player: Character) -> DefendPower:
	var TotalDefense: DefendPower = DefendPower.new();
	var combatModifiers: CombatModifiers = mPlayerEquipmentManager.GetEquipmentModifiers(); # Bad code this runs twice: see _GetPlayerDamageOutput
	TotalDefense.PhysicalDefense += Player.Defense + combatModifiers.DefenseModifier;
	TotalDefense.MagicDefense += Player.MagicDefense + combatModifiers.MagicDefenseModifier;
	print_debug("Player gear defense: " + str(combatModifiers.DefenseModifier) + "    Magic Defense: " + str(combatModifiers.MagicDefenseModifier))
	return TotalDefense;

func _GetNPCDamageOutput(NPC: Character) -> DamageHit:
	var TotalDamage: DamageHit = DamageHit.new();
	TotalDamage.PhysicalDamage += NPC.Damage;
	TotalDamage.MagicDamage += NPC.MagicDamage;
	return TotalDamage;

func _GetNPCDefense(NPC: Character) -> DefendPower:
	var TotalDefense: DefendPower = DefendPower.new();
	TotalDefense.PhysicalDefense += NPC.Defense;
	TotalDefense.MagicDefense += NPC.MagicDefense;
	return TotalDefense;

func BeginCombat():
	IsCombatActive = true;

func EndCombat():
	IsCombatActive = false;

func HandleCharacterDeath():
	# Enemy Death
	if (mCharacterRegister.mActiveEnemyCharacter.CurrentHealth <= 0):
		var LootDrop: Array[InvSlot] = mCharacterRegister.KillEnemy();
		AddLootDropToInv(LootDrop); # Drop Loot
		mCharacterDisplayController.EnemyDisplay.PlayDeathAnimation();
		EndCombat();
	# Player Death
	if (mCharacterRegister.mActiveCharacter.CurrentHealth <= 0):
		mCharacterDisplayController.PlayerDisplay.PlayDeathAnimation();
		EndCombat();

func AddLootDropToInv(lootDrop: Array[InvSlot]):
	# foreach InventorySlot
	for i in range(0, lootDrop.size()):
		for n in range(0, lootDrop[i].amount):
			mInventoryUI.GetInventory().insert(lootDrop[i].item); # Drop Loot
