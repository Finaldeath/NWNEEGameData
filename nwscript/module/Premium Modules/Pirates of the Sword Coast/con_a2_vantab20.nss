//::///////////////////////////////////////////////
//:: con_a2_vantab20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC agreed to help Vantabular solve
    the puzzle of his hidden treasure?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_VANTAB");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
