#include "NW_I0_PLOT"

int StartingConditional()
{
    object oDress = GetItemInSlot(INVENTORY_SLOT_CHEST,GetPCSpeaker());
    if ((GetTag(oDress) == "pm_custom_tunic" || GetTag(oDress) == "pm_custom_dress")
    && GetLocalInt(GetModule(), "doorman")==1)
    {
        return TRUE;
    }
    return FALSE;
}
