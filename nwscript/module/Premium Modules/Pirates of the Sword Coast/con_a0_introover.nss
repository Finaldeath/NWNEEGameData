//::///////////////////////////////////////////////
//:: con_a0_introover
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard the Captains intro dialog?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iIntroOver = GetLocalInt(oSelf, "A0_INTROOVER");

    if(iIntroOver == TRUE)
    {
        return TRUE;
    }

    return FALSE;

}
