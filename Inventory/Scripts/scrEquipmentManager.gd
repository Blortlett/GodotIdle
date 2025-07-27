class_name EquipmentManager extends Control
# Inventory Component
@onready var mInventory: Inv = preload("res://Inventory/PlayerEquipmentInventory.tres");
var isOpen = true;

# Inventory UI
@onready var mSlotContainer: Control = $Slots
@export var mEquipmentSlotsUI: Array[SlotUI]

# Prep the visual to describe equipment slot item type
func _PrepAllSlotVisuals():
	# Load empty Helmet slot decal 
	var texture: Resource = load("res://Art/Items/EquipmentShadows/Helmet.png");
	_PrepSlotVisual(texture, mEquipmentSlotsUI[0]);
	# Load empty Chestplate slot decal 
	texture = load("res://Art/Items/EquipmentShadows/Chestplate.png");
	_PrepSlotVisual(texture, mEquipmentSlotsUI[1]);
	# Load empty Legs slot decal 
	texture = load("res://Art/Items/EquipmentShadows/Legs.png");
	_PrepSlotVisual(texture, mEquipmentSlotsUI[2]);
	# Load empty Boots slot decal 
	texture = load("res://Art/Items/EquipmentShadows/Boots.png");
	_PrepSlotVisual(texture, mEquipmentSlotsUI[3]);
	# Load empty weapon slot decal
	texture = load("res://Art/Items/EquipmentShadows/Sword.png");
	_PrepSlotVisual(texture, mEquipmentSlotsUI[4]);
	# Load empty Accessory slot decal
	texture = load("res://Art/Items/EquipmentShadows/Accessory.png");
	_PrepSlotVisual(texture, mEquipmentSlotsUI[5]);

func _PrepSlotVisual(_IconTexture: Resource, _SlotUI: Node):
	var SlotIcon = Sprite2D.new();
	SlotIcon.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST;
	SlotIcon.texture = _IconTexture;
	_SlotUI.add_child(SlotIcon);
	SlotIcon.position = Vector2(0, 0);
	SlotIcon.scale = Vector2(.8,.8);

func _ready() -> void:
	_PrepAllSlotVisuals();
	mInventory.update.connect(UpdateSlots);
	UpdateSlots();
	open();

func UpdateSlots():
	print_debug(mInventory.slots.size())
	# Update Armor Slots
	for i in range(6):
		mEquipmentSlotsUI[i].update(mInventory.slots[i])

func open():
	mSlotContainer.visible = true;
	isOpen = true;

func close():
	mSlotContainer.visible = false;
	isOpen = false;

func GetInventory() -> Inv:
	return mInventory;

func GetEquipmentModifiers() -> CombatModifiers:
	var EquipmentModifiers: CombatModifiers = CombatModifiers.new();
	if GetWeaponItem():
		EquipmentModifiers.DamageModifier += GetWeaponItem().DamageModifier;
		EquipmentModifiers.MagicDamageModifier += GetWeaponItem().MagicDamageModifier;
	if GetHelmetItem():
		EquipmentModifiers.MagicDefenseModifier += GetHelmetItem().MagicDefenseModifier;
		EquipmentModifiers.DefenseModifier += GetHelmetItem().DefenseModifier;
	return EquipmentModifiers;

func GetUISlots() -> Array[SlotUI]: # Get all slots
	var EquipmentSlots: Array[SlotUI];
	for slot: SlotUI in mEquipmentSlotsUI:
		EquipmentSlots.append(slot);
	return EquipmentSlots;
# Get Specific Slots
func GetHelmetItem() -> InvItem:
	return mInventory.slots[0].item;
func GetChestItem() -> InvItem:
	return mInventory.slots[1].item;
func GetLegItem() -> InvItem:
	return mInventory.slots[2].item;
func GetBootItem() -> InvItem:
	return mInventory.slots[3].item;
func GetWeaponItem() -> InvItem:
	return mInventory.slots[4].item;
func GetAccessoryItem() -> InvItem:
	return mInventory.slots[5].item;
