class_name LootTable extends Resource
@export var mLootTable: Array[LootTableEntry];

func SpawnLootDrop() -> Array[InvSlot]:
	var LootPack: Array[InvSlot];
	for i in range(0, mLootTable.size()):
		var spawnAmount = randi_range(mLootTable[i].MinAmount, mLootTable[i].MaxAmount);
		LootPack[i] = InvSlot.new(mLootTable[i].item, spawnAmount);
	return LootPack;
