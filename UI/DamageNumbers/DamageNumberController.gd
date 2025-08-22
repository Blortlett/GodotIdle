class_name DamageNumberController extends Control
@export var NumberDamageColor: LabelSettings
@export var NumberHealColor: LabelSettings

# If i have time I will come back and object pool this...
func TriggerDamageNumber(dmgValue: float):
	# Creating new dmg number
	var scene: PackedScene = load("res://UI/DamageNumbers/nDmgNumber.tscn")
	var newDmgNumber: Label = scene.instantiate() as Label
	self.add_child(newDmgNumber)

	
	#Set number to healing or damage style
	if (dmgValue < 0): # CharacterHealing
		newDmgNumber.label_settings = NumberHealColor
		newDmgNumber.text = "+"
		dmgValue *= -1
	else: # Character damaged
		newDmgNumber.label_settings = NumberDamageColor
		newDmgNumber.text = "-"
	
	# Change text and display
	newDmgNumber.text += str(int(dmgValue))
	newDmgNumber.visible = true;
