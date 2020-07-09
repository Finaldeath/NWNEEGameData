// secret: buried zhent: player uses healing potion on zhent

void DestroyItems(object oPC, string sTag, int nAmount)
{
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem) == TRUE && nAmount > 0)
    {
        if (GetTag(oItem) == sTag)
        {
            int nStackSize = GetItemStackSize(oItem);
            if (nStackSize > nAmount)
            {
                SetItemStackSize(oItem, nStackSize - nAmount);
                nAmount = 0;
            }
            else
            {
                DestroyObject(oItem);
                nAmount -= nStackSize;
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}

int UseItem(object oPC, object oTarget, string sTag)
{
    object oItem = GetItemPossessedBy(oPC, sTag);
    if (GetIsObjectValid(oItem))
    {
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        DestroyItems(oPC, sTag, 1);
        return TRUE;
    }
    return FALSE;
}

void main()
{
    object oPC = GetPCSpeaker();
    object oZhent = OBJECT_SELF;

    if (UseItem(oPC, oZhent, "NW_IT_MPOTION001")) return;
    if (UseItem(oPC, oZhent, "NW_IT_MPOTION020")) return;
    if (UseItem(oPC, oZhent, "NW_IT_MPOTION002")) return;
    if (UseItem(oPC, oZhent, "NW_IT_MPOTION003")) return;
    if (UseItem(oPC, oZhent, "NW_IT_MPOTION012")) return;
}

