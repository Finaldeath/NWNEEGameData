//::///////////////////////////////////////////////
//:: nhb_a3_ghost
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Ghost walk waypoint and processes hearbeats
    only when a PC is in the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetNearestCreature
        (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

    // if there's a PC in the area runscript
    if (GetArea(oPC) == GetArea(oSelf))
    {
        ExecuteScript("nw_c2_default1", oSelf);
    }
}
