//:://////////////////////////////////////////////
//:: con_a0_escort50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tasina is safely aboard the Midnight Rose
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int Escort = GetLocalInt(GetModule(), "A0_ESCORT");

    if(Escort >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
