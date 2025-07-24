extends Control

@onready var mInventoryTarget: InventoryUI = get_node("../../..");
@export var mItem: InvItem;

signal AddItemToInventory;

func _ready() -> void:
	# Set icons to item# Set item sprite from ItemID
		var xPos : int = ((mItem.ItemID % 16) - 1) * 32;
		var yPos: int = (mItem.ItemID / 16) * 32;
		var regionPosition : Vector2 = Vector2(xPos, yPos);
		$AddApple/NinePatchButton/sprIcon.region_rect.position = regionPosition;
		$AddApple/NinePatchButton/sprIcon.region_rect.size = Vector2(32, 32);
	
func _on_add_apple_pressed() -> void:
	print_debug("Adding apple to inventory!");
	mInventoryTarget.inv.insert(mItem);
