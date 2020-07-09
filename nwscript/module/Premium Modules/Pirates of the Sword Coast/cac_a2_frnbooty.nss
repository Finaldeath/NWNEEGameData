//::///////////////////////////////////////////////
//:: cac_a2_frnbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Francis sells his booty.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////
#include "inc_bootysystem"

void main()
{
    object oPC = GetPCSpeaker();
    object oFrancis = OBJECT_SELF;
    object oModule = GetModule();
    int iBootyCount = GetLocalInt(oModule, "POTSC_BOOTYCOUNT");

    SetLocalInt(oModule, "POTSC_BOOTYCOUNT", (iBootyCount + 1));
    SetLocalInt(oFrancis, "TRE_BOOTY", TRUE);
    TakeGoldFromCreature(100, oPC);
    CreateBootyOnObject(oPC, BOOTY_GENERIC);
}
