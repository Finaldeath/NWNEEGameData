//////////////////////////////////////////////////////////////////
// dla_ct_needbow - Need a crossbow or bow for the competition
// Original Scripter: Deva B. Winblood
// Last Modified By:  Deva B. Winblood  5/3/2006
/////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,GetPCSpeaker());
    int nBT=GetBaseItemType(oItem);
    if (GetIsObjectValid(oItem))
    { // has item in right hand
      if (nBT==BASE_ITEM_LIGHTCROSSBOW||nBT==BASE_ITEM_HEAVYCROSSBOW||nBT==BASE_ITEM_LONGBOW||nBT==BASE_ITEM_SHORTBOW)
      { // have bow
        return FALSE;
      } // have bow
    } // has item in right hand
    return TRUE;
}
