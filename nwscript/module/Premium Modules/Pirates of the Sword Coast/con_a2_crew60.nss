//::///////////////////////////////////////////////
//:: con_a2_crew60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player gathered a full crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_CREW");

    if(iPlot >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
