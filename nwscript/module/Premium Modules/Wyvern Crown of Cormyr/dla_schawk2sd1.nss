// B W-Husey
// October 2005
// PC knows Hawklin paid for the charter - used in salvatori3 dialogue.

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Inspect local variables
    if(!(GetLocalInt(oPC, "nHawklinDebt") > 0)) return FALSE;
    //else proceed
    return TRUE;
}
