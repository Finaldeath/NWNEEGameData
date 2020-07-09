//::///////////////////////////////////////////////
//:: con_a2_crewl60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC still need more crew members?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_CREW");

    if(iPlot < 60)
    {
        return TRUE;
    }

    return FALSE;

}
