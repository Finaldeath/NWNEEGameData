//::///////////////////////////////////////////////
//:: cac_a2_tlblue
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Set the puzzle tiles temporary color
     to blue. Note: the actual value and
     calculations are managed in "cac_a2_tlset".
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

#include "inc_puz_crstpzzl"

void main()
{
    object oTile = OBJECT_SELF;
    SetLocalInt(oTile, "iTempColor", COLOR_BLUE);
}
