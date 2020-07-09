//::///////////////////////////////////////////////
//:: con_a2_franc80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The ring has been returned to francis and
    he has joined the crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if(iPlot >= 80)
    {
        return TRUE;
    }

    return FALSE;

}
