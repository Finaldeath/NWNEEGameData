//::///////////////////////////////////////////////
//:: dla_inv_close
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Runned when the inventory being managed by the player is closed
    returns and equip the items to the owner NPC
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 5 Feb 2006
//:://////////////////////////////////////////////

#include "dla_x0_inventory"

void main()
{
    object oMilitia = GetLocalObject(OBJECT_SELF, "DLA_MILITIA");
    if (GetIsPC(GetLastClosedBy()) == TRUE)
    {
        CopyBack(OBJECT_SELF, oMilitia);
        DestroyEquipped(oMilitia);
        DestroyObject(OBJECT_SELF, 0.1);
    }
}
