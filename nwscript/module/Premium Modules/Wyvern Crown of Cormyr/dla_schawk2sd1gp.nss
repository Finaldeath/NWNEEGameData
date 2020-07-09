// B W-Husey
// October 2005
// PC wants to repay debt from Payment for the Charter

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Inspect local variables
    if(!(GetLocalInt(oPC, "nHawklinDebt") < 10)) return FALSE;
    if(!(GetLocalInt(oPC, "nHawklinDebt") > 0)) return FALSE;
    if (GetGold(oPC)<1000) return FALSE;
    //else proceed
    return TRUE;
}
