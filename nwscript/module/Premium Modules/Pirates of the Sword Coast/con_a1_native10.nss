//::///////////////////////////////////////////////
//:: con_a1_native10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Player found the corpse of a fellow sailor
    and has seen the footprints in the sand?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
