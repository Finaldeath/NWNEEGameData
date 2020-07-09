#include "NW_I0_PLOT"

int StartingConditional()
{
    object oDress = GetItemInSlot(INVENTORY_SLOT_CHEST,GetPCSpeaker());
    if (GetTag(oDress) == "pm_marinerrobe" || GetTag(oDress) == "pm_marinerrobe2")
    {
        return TRUE;
    }
    return FALSE;
}
