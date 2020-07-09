// returns TRUE if PC agreed to kill gnolls in wild hills

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "nWH_OgreDeal") == 1) return TRUE;
    else return FALSE;
}
