//::///////////////////////////////////////////////
//:: cac_a2_wllbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Willigan sells his booty.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////
#include "inc_bootysystem"

void main()
{
    object oPC = GetPCSpeaker();
    object oWilligan = OBJECT_SELF;
    object oModule = GetModule();
    int iBootyCount = GetLocalInt(oModule, "POTSC_BOOTYCOUNT");

    SetLocalInt(oModule, "POTSC_BOOTYCOUNT", (iBootyCount + 1));
    SetLocalInt(oWilligan, "TRE_BOOTY", TRUE);
    TakeGoldFromCreature(100, oPC);
    CreateBootyOnObject(oPC, BOOTY_GENERIC);
}
