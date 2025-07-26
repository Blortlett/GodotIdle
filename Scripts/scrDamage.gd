class_name DamageHit

func _init(	_PhysicalDamage: float, 
		_StunImpact: float, 
		_MagicDamage: float, 
		_PoisonDamage: float, 
		_FrostImpact: float, 
		_FireImpact) -> void:
	PhysicalDamage = _PhysicalDamage;
	StunImpact = _StunImpact;
	MagicDamage = _MagicDamage;
	PoisonDamage = _PoisonDamage;
	FrostImpact = _FrostImpact;
	FireImpact = _FireImpact;

var PhysicalDamage: float;
var StunImpact: float;
var MagicDamage: float;
var PoisonDamage: float;
var FrostImpact: float;
var FireImpact: float;
