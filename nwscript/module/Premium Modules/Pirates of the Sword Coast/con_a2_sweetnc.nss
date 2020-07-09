//::///////////////////////////////////////////////
//:: con_a2_sweetnc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Sweet Marie an available crewmember
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
    int iInCrew = GetLocalInt(oModule, "POTSC_CREW_SWEET");
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if ((iPlot >= 50) && (iInCrew == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
