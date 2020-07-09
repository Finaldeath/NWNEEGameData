//::///////////////////////////////////////////////
//:: con_a2_kolmar20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have atleast two crewmen for the
    skull and bones?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(oModule, "A2_NECRO");
    int iCrew = GetLocalInt(oModule, "A2_CREWCOUNT");

    if((iPlot >= 10) && (iCrew >= 2))
    {
        return TRUE;
    }

    return FALSE;
}
