//::///////////////////////////////////////////////
//:: ndt_a3_avatar
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Avatar boss in act 3 has been slain.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
#include "_inc_generic"

void main()
{
    //end of module
    object oPC = GetFirstPC();
    object oModule = GetModule();
    object oEndArea = GetObjectByTag("A3_FNL_SFSPAWN");
    location lTarget = GetLocation(oEndArea);

    SetLocalInt(oModule, "A3_WATER", 90);
    AddJournalQuestEntry("a3_water", 90, oPC);
    DelayCommand(3.0, JumpPCsToLocation(lTarget, 2));
}
