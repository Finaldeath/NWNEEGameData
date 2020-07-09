//::///////////////////////////////////////////////
//:: cac_a2_lgrbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Langer Gives away his booty.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////
#include "inc_bootysystem"

void main()
{
    object oPC = GetPCSpeaker();
    object oLanger = OBJECT_SELF;
    object oModule = GetModule();
    int iBootyCount = GetLocalInt(oModule, "POTSC_BOOTYCOUNT");

    SetLocalInt(oModule, "POTSC_BOOTYCOUNT", (iBootyCount + 1));
    SetLocalInt(oLanger, "TRE_BOOTY", TRUE);

    //Langer gives his booty away to the PC if they save him.
    //TakeGoldFromCreature(100, oPC);

    CreateBootyOnObject(oPC, BOOTY_GENERIC);
}
