//::///////////////////////////////////////////////
//:: cac_a2_pfegold
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have enought gold?
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 17, 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    if (wsHaveEnoughGoldForCurrentItemProperty(GetPCSpeaker()) == TRUE)
    {
        return TRUE;
    }
    return FALSE;
}
