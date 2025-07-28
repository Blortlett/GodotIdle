class_name DamageNumberController extends Control
@export var NumberDamageColor: LabelSettings
@export var NumberHealColor: LabelSettings

# If i have time I will come back and object pool this...
func TriggerDamageNumber(dmgValue: float):
	# Creating new dmg number
	var scene: PackedScene = load("res://UI/DamageNumbers/nDmgNumber.tscn")
	var newDmgNumber: Label = scene.instantiate() as Label
	self.add_child(newDmgNumber)
	newDmgNumber.position = Vector2(0,0)
	var DmgNumBehavior: DamageNumberBehavior = newDmgNumber;
	
	#Set number to healing or damage style
	if (dmgValue < 0): # CharacterHealing
		newDmgNumber.label_settings = NumberHealColor
		newDmgNumber.text = "+DDD"
	else: # Character damaged
		newDmgNumber.label_settings = NumberDamageColor
		newDmgNumber.text = "-DDD"
	
	# Change text and display
	#newDmgNumber.text += str(int(dmgValue))
	newDmgNumber.visible = true;
