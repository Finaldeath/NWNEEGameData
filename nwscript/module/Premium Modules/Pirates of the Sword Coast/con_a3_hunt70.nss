//::///////////////////////////////////////////////
//:: con_a3_hunt70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Kolmarr has opened a strange gate at the top
    of the hill and entered the portal. He has
    told you to follow him.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_HUNT");

    if(iPlot >= 70)
    {
        return TRUE;
    }

    return FALSE;

}
