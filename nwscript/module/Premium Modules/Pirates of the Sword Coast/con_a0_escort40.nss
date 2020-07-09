//:://////////////////////////////////////////////
//:: con_a0_escort40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Tasina opened the door and joined the PC's
    party?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_ESCORT");

    if(iStatue >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
