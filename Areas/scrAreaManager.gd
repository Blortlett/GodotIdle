extends Node

class_name AreaManager;
enum AreaType
{
	None,
	Field,
	Graveyard,
	Canyon
}

@export var mExplorableAreas: Array[ExplorableArea];
var mCurrentArea: ExplorableArea;

func SwapArea(_areaType: AreaType):
	match _areaType:
		AreaType.None:
			mCurrentArea = null
		AreaType.Field:
			mCurrentArea = mExplorableAreas[0]
		AreaType.Graveyard:
			mCurrentArea = mExplorableAreas[1]
		AreaType.Canyon:
			mCurrentArea =mExplorableAreas[2]
