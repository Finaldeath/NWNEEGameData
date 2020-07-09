//::///////////////////////////////////////////////
//:: nsp_grayooze
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawn event for the Gray Ooze NPCs in Islands
    of Peril.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
//:://////////////////////////////////////////////
#include "x0_i0_anims"
#include "x2_inc_switches"
#include "inc_balance"

void main()
{
    object oSelf = OBJECT_SELF;

    LevelUpNPC(OBJECT_SELF);

    SetSpawnInCondition(NW_FLAG_STEALTH);
    ExecuteScript("exe_gen_loot", OBJECT_SELF);
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
