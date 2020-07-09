//::///////////////////////////////////////////////
//:: con_a2_sweet50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sweetie Marie has agreed to join your crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if(iPlot >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
