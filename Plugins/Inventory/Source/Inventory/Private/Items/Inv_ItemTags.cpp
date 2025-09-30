#include "Items/Inv_ItemTags.h"


namespace GameItems
{
	namespace GameItems::Equipment
	{
		namespace Weapons
		{
			UE_DEFINE_GAMEPLAY_TAG(Axe, "GameItems.Equipment.Weapons.Axe")
			UE_DEFINE_GAMEPLAY_TAG(Sword,"GameItems.Equipment.Weapons.Sword")
		}

		namespace Cloaks
		{
			UE_DEFINE_GAMEPLAY_TAG(RedCloak, "GameItems.Equipment.Cloaks.RedCloak")
		}

		namespace Masks
		{
			UE_DEFINE_GAMEPLAY_TAG(SteelMask, "GameItems.Equipment.Masks.SteelMask")
		}
	}

	namespace Consumables::Potions
	{
		namespace Red
		{
			UE_DEFINE_GAMEPLAY_TAG(Small, "GameItems.Consumables.Red.Small")
			UE_DEFINE_GAMEPLAY_TAG(Large, "GameItems.Consumables.Red.Large")
		}

		namespace Blue
		{
			UE_DEFINE_GAMEPLAY_TAG(Small, "GameItems.Consumables.Blue.Small")
			UE_DEFINE_GAMEPLAY_TAG(Large, "GameItems.Consumables.Blue.Large")
		}
	}

	namespace Craftables
	{
		UE_DEFINE_GAMEPLAY_TAG(FireFernFruit, "GameItems.Craftables.FireGernFruit")
		UE_DEFINE_GAMEPLAY_TAG(LuminDaisy, "GameItems.Craftables.LuminDaisy")
		UE_DEFINE_GAMEPLAY_TAG(ScorchPetalBlossom, "GameItems.Craftables.ScorchPetalBlossom")
	}
}
