//:://////////////////////////////////////////////
//:: con_a0_escrtdone
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the Escort Plot Complete?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iEscort = GetLocalInt(GetModule(), "A0_ESCORTPLOTDONE");

    if(iEscort == TRUE)
    {
        return TRUE;
    }

    return FALSE;

}
