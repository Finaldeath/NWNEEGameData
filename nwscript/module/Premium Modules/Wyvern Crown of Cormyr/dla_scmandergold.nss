/*
    dla_mandergold
    B W-Husey
    May 13, 2006

    checks if player has enough gold
*/
int StartingConditional()
{
    object oSelf = OBJECT_SELF,
           oPC = GetPCSpeaker();
    if (GetGold(oPC) < GetLocalInt(oPC, "nTMapCost")) return FALSE;
    return TRUE;
}
