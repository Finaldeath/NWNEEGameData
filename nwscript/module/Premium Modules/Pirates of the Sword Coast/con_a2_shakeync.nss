//::///////////////////////////////////////////////
//:: con_a2_shakeync
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Skakey McGuire an available crewmember
    but not yet added to the Skull and Bones
    Roster?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iInCrew = GetLocalInt(oModule, "POTSC_CREW_SHAKEY");
    int iPlot = GetLocalInt(GetModule(), "A2_SHAKEY");

    if ((iPlot >= 30) && (iInCrew == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
