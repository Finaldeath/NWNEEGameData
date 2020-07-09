//::///////////////////////////////////////////////
//:: con_a3_seige20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Ship is under attack, the Player must
    fend of the attacking sahaugin while
    preventing the ship from sinking.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_SEIGE");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
