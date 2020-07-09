//::///////////////////////////////////////////////
//:: con_a0_allynone
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check and see if the PC Is NOT allied with the
    Bloodsailors or the Black River Bandits in
    Act 0.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iBloodAllies = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
    int iBRBAllies = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");

    int iResult = FALSE;

    // if the PC allies with neither of the Docks factions return true.
    if ((iBloodAllies != TRUE) && (iBRBAllies != TRUE))
    {
        iResult = TRUE;
    }

    return iResult;
}
