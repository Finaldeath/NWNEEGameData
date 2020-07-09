//:://////////////////////////////////////////////
//:: con_a0_escort20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned that Tasina is underseige
    by the Brigands she betrayed?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_ESCORT");

    if(iStatue >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
