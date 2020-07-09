/*
    DLA_SCSMITHGOLD.nss
    gaoneng erick
    may 12, 2005

    checks if player has enough gold
*/
int StartingConditional()
{
    object oSelf = OBJECT_SELF,
           oPC = GetPCSpeaker();
    if (GetGold(oPC) > GetLocalInt(oSelf, "nCost")) return FALSE;
    return TRUE;
}
