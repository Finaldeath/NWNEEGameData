//::///////////////////////////////////////////////
//:: cac_a2_tlsouthw
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Set the puzzle tiles temporary direction
     to South West. Note: the actual value and
     calculations are managed in "cac_a2_tlset".
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

void main()
{
    object oTile = OBJECT_SELF;
    SetLocalInt(oTile, "iTempDirection", 6);
}
