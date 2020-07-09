//::///////////////////////////////////////////////
//:: con_a2_skbrstr2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the Roster of the Skull and bone have
    atleast two members?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iRoster = GetLocalInt(oModule, "POTSC_CREW_ROASTER");
    int iResult = FALSE;

    if (iRoster >= 2)
    {
        iResult = TRUE;
    }

    return iResult;
}
