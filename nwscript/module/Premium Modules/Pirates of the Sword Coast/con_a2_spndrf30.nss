//::///////////////////////////////////////////////
//:: con_a2_spndrf30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You can enter the Temple of Umberlee in
    Spindrift and interact with the guards and
    priestesses.

    They speak of Tasina's return with the statue,
    but you’re told that you are not allowed to
    meet with her, as she's engaged in an
    important ritual inside.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;
}
