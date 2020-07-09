#include "x0_i0_walkway"

void main()
{
    if((GetTag(GetArea(OBJECT_SELF)) == "C1AR1000_GilliansHill") &&
        GetLocalInt(OBJECT_SELF, "has_met_pc") == 1)
    {
        SetLocalInt(OBJECT_SELF, "no_banter", 1);
        SetLocked(GetObjectByTag("C1AR1000_C1AR1004_EXIT"), FALSE);
        ActionMoveToObject(GetObjectByTag("POST_ac_sejellus"), TRUE);
        ActionDoCommand(SetFacing(DIRECTION_WEST));
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "no_banter", 0));
        object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
        ActionDoCommand(ActionUnequipItem(oTorch));
        ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE));
        ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE));
    }
}
