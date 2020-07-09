/*
    DLA_SCSMITHSTEEL.nss
    B W-Husey
    Generic conditional. PC has enough gold to craft with steel.
*/
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) < GetLocalInt(oPC, "nCraftCost")) return FALSE;
    return TRUE;
}


