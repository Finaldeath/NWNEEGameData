//::///////////////////////////////////////////////
//:: con_a0_escort10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has PC has been told to meet Tasina at the Golden
    apple?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_ESCORT");

    if(iStatue >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
