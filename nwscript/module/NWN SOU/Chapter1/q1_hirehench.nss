//:://////////////////////////////////////////////////
//:: Q1_HireHench
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
Handles the hiring of a henchman.
 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 09/13/2002
//:://////////////////////////////////////////////////

#include "x0_i0_henchman"

void main()
{
    SetImmortal(OBJECT_SELF, FALSE);
    HireHenchman(GetPCSpeaker());
}