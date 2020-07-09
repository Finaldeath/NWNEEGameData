// returns true if the player has a healing potion

int HasItem(object oPC, string sTag)
{
    object oItem = GetItemPossessedBy(oPC, sTag);
    return (GetIsObjectValid(oItem));
}

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (HasItem(oPC, "NW_IT_MPOTION001")) return TRUE;
    if (HasItem(oPC, "NW_IT_MPOTION020")) return TRUE;
    if (HasItem(oPC, "NW_IT_MPOTION002")) return TRUE;
    if (HasItem(oPC, "NW_IT_MPOTION003")) return TRUE;
    if (HasItem(oPC, "NW_IT_MPOTION012")) return TRUE;
    return FALSE;
}
