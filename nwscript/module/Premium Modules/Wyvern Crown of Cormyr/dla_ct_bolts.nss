//////////////////////////////////////////////////////////////////
// dla_ct_bolts - Need at least 18 arrows/bolts
// Original Scripter: Deva B. Winblood
// Last Modified By:  Deva B. Winblood   5/4/2006
/////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oItem=GetItemInSlot(INVENTORY_SLOT_BOLTS,GetPCSpeaker());
    object oBow=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    int nBT=GetBaseItemType(oBow);
    if (nBT!=BASE_ITEM_HEAVYCROSSBOW||nBT!=BASE_ITEM_LIGHTCROSSBOW) return FALSE;
    if (!GetIsObjectValid(oItem)) return TRUE;
    if (GetItemStackSize(oItem)<18) return TRUE;
    return FALSE;
}
