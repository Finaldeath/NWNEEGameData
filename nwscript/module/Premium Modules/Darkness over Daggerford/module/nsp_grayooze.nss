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
    SetLocalInt(OBJECT_SELF, "X2_L_NOTREASURE", 1);
    SetSpawnInCondition(NW_FLAG_STEALTH);
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
