//::///////////////////////////////////////////////
//:: con_a3_dead50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Pirate Captain is defeated; you can
    claim the Skull & Bones as your own and
    head out after Tasina.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_DEAD");

    if(iPlot >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
