//::///////////////////////////////////////////////
//:: con_a2_crewe60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player gathered a exactly full crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(oModule, "A2_CREW");
    int iCrew = GetLocalInt(oModule, "A2_CREWCOUNT");

    if((iPlot == 60) && (iCrew == 5))
    {
        return TRUE;
    }

    return FALSE;

}
