//::///////////////////////////////////////////////
//:: con_a2_blackrnc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Honeypea an available crewmember but not
    yet added to the Skull and Bones Roster?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iInCrew = GetLocalInt(oModule, "POTSC_CREW_BLACKR");
    int iPlot = GetLocalInt(oModule, "A2_BLACKR");

    if((iPlot >= 30) && (iInCrew == FALSE))
    {
        return TRUE;
    }

    return FALSE;

}
