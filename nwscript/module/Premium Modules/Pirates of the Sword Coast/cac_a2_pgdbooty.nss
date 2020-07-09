//::///////////////////////////////////////////////
//:: cac_a2_pgdbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Prison Guard sells his booty.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////
#include "inc_bootysystem"

void main()
{
    object oPC = GetPCSpeaker();
    object oGuard = OBJECT_SELF;
    object oModule = GetModule();
    int iBootyCount = GetLocalInt(oModule, "POTSC_BOOTYCOUNT");

    SetLocalInt(oModule, "POTSC_BOOTYCOUNT", (iBootyCount + 1));
    SetLocalInt(oGuard, "TRE_BOOTY", TRUE);
    TakeGoldFromCreature(100, oPC);
    CreateBootyOnObject(oPC, BOOTY_GENERIC);
}
