// B W-Husey
// October 2005
// PC repaid Hawklin for the charter - used in salvatori3 dialogue.

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Inspect local variables
    if(GetLocalInt(oPC, "nHawklinDebt") != 10) return FALSE;
    //else proceed
    return TRUE;
}
