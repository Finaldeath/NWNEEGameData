//::///////////////////////////////////////////////
//:: dla_schawk2sd19
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Conditional script.
    PC can still repay Hawklin for the charter
    used in salvatori3 dialogue.
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: October 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Inspect local variables
    if(!(GetLocalInt(oPC, "nHawklinDebt") < 10)) return FALSE;
    //else proceed
    return TRUE;
}
