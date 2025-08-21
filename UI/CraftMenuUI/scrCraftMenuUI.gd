class_name CraftMenu extends Control;
# Player inventory
@onready var mPlayerInventoryUI: InventoryUI = get_tree().get_root().get_node("Node/GameUI")
@onready var mPlayerInventory: Inv = mPlayerInventoryUI.GetInventory()
# Button name list
var ButtonNames: Array[String];
# -= Craftable Item UI =-
# Crafting Slot button storage
@export var ButtonParent: GridContainer;
# Button spawnable:
@export var CraftButtonSpawnable: PackedScene = preload("res://UI/CraftMenuUI/CraftSlot/nCraftableSlot.tscn")
var mCraftButtons: Array[Control];
#-= Craft Output Slot =-
@export var mCraftOutputDescription: CraftOutputDescription
var mOutputInvSlot: InvSlot = InvSlot.new()
@onready var mOutputInvSlotUI: InventoryUI = get_node("CraftOutputSlot")
# Selected recipe
var mIsRecipeSelected: bool = false;
var mSelectedRecipe: Recipe = null;

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
# Crafting Dictionary:
@onready var mCraftingDictionary: CraftRecipies = get_node("GridContainer")

# HomeButton
@onready var mHomeButton: Control = get_node("Button");

func _ready() -> void:
	mHomeButton.pressed.connect(ReturnHome)
	mGameStateManager.state_changed.connect(CheckMenuOpen)
	#mOutputInvSlotUI.update(mOutputInvSlot)
	mCraftOutputDescription.mCraftMenuUI = self

func RefreshCraftables():
	print_debug(":: CRAFTING ::")
	var CraftableRecipes: Array[Recipe] = mCraftingDictionary.GetCraftableRecipies()
	for i in range(CraftableRecipes.size()):
		var craftButton: CraftableSlotUI= CraftButtonSpawnable.instantiate()
		craftButton.SetDisplayItem(CraftableRecipes[i])
		craftButton.mOwnerUI = self
		mCraftButtons.append(craftButton)
		ButtonParent.add_child(craftButton)
		print_debug("recipe craftable: " + CraftableRecipes[i].Products[0].Item.name)

func SetCraftOutputTarget(_CraftOutputTarget: Recipe):
	if !_CraftOutputTarget:
		print("Craft target set to empty object!")
		return
	mIsRecipeSelected = true;
	mSelectedRecipe = _CraftOutputTarget
	mCraftOutputDescription.SetDescription(_CraftOutputTarget)

func CraftItem():
	var CanCraft: bool = true
	# Check we have all ingredients
	for ingredient: ItemAmount in mSelectedRecipe.Ingredients:
		if !mPlayerInventory.CheckHasItems(ingredient):
			CanCraft = false;
	if !CanCraft: return # Can't craft so you should return
	print("Crafting: " + mSelectedRecipe.Products[0].Item.name)
	# Remove ingredients from player inventory
	for ingredient: ItemAmount in mSelectedRecipe.Ingredients:
		mPlayerInventory.remove(ingredient)
	# Insert crafted item into craft output slot
	mOutputInvSlotUI.GetInventory().insert(mSelectedRecipe.Products[0].Item)
	RemoveCraftables()
	RefreshCraftables()

func RemoveCraftables():
	for child in ButtonParent.get_children():
		child.queue_free()

# -= Menu functionality =-
#Home Button
func ReturnHome():
	mGameStateManager.SwapToHomeState()
# Listen for menu Open/Close
func CheckMenuOpen(new_state_type: GameState.StateType):
	if new_state_type == GameState.StateType.CRAFTING:
		RefreshCraftables()
	else:
		RemoveCraftables()
		mCraftOutputDescription.ClearDescription()
