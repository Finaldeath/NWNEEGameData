//::///////////////////////////////////////////////
//:: con_a2_francnc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Sir Francis an available crewmember
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
    int iInCrew = GetLocalInt(oModule, "POTSC_CREW_FRANCIS");
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if ((iPlot >= 80) && (iInCrew == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
