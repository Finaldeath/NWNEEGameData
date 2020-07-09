//::///////////////////////////////////////////////
//:: con_a3_seige30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully plugged the holes,
    now to finish off the sahaugin invaders.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_SEIGE");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
