//::///////////////////////////////////////////////
//:: con_a2_whipdnc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Whipped Willigan an available crewmember
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
    int iInCrew = GetLocalInt(oModule, "POTSC_CREW_WILLIGAN");
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if((iPlot >= 50) && (iInCrew == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
