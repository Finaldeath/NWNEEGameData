// returns TRUE if PC carries as much gold as their toll price

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nToll  = GetLocalInt(oPC, "nWH_TollPrice");

    if (GetGold(oPC) >= nToll) return TRUE;
    else return FALSE;
}
