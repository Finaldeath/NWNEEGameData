//:://////////////////////////////////////////////////
//:: X0_D2_HEN_rln-047
//::
//:: Copyright (c) 2003
//:://////////////////////////////////////////////////
/*
Check to see if henchman should make this one-liner.
 */
//:://////////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: August 2003
//:://////////////////////////////////////////////////


#include "x0_i0_henchman"

int StartingConditional()
{
    if(GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL)
    {
        return (GetOneLiner() == -047);
    }
    return FALSE;
}
