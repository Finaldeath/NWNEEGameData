//::///////////////////////////////////////////////
//:: con_a2_redtipnc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Redtip an available crewmember
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
    int iInCrew = GetLocalInt(oModule, "POTSC_CREW_REDTIP");
    int iPlot = GetLocalInt(GetModule(), "A2_REDTIP");

    if ((iPlot >= 40) && (iInCrew == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
