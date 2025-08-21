class_name CraftableSlotUI extends Node
@export var mInvSlotUI: SlotUI
var mInvSlot: InvSlot = InvSlot.new()
var mActiveRecipe: Recipe
var mOwnerUI: CraftMenu

func SetDisplayItem(_recipe: Recipe):
	mActiveRecipe = _recipe
	mInvSlot.item = _recipe.Products[0].Item
	mInvSlotUI.update(mInvSlot)

func _on_inv_slot_ui_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				# Give CraftMenuUI the mInvSlot.item
				print("Left mouse button clicked on Control node!")
				mOwnerUI.SetCraftOutputTarget(mActiveRecipe)
