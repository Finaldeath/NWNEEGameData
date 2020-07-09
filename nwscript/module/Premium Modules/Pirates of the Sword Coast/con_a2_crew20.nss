//::///////////////////////////////////////////////
//:: con_a2_crew20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have atleast one crewmember?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_CREW");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
