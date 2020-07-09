//::///////////////////////////////////////////////
//:: con_a1_native60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Has a player collected the equipment he needs
   and has agreed to go out and fight Garm?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
