//::///////////////////////////////////////////////
//:: con_a2_langernc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Longneck Langer an available crewmember
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
    int iInCrew = GetLocalInt(oModule, "POTSC_CREW_LANGER");
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if ((iPlot >= 60) && (iInCrew == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
