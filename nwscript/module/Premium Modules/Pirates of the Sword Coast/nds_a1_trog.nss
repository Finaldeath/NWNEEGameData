//::///////////////////////////////////////////////
//:: Name nds_a1_trog
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDisturbed script for Troglodytes
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oDisturber = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();
    int iHostile = GetLocalInt(oModule, "A1_NATIVES");
    int iEXP = GetJournalQuestExperience("a1_natives");

    // if the attacker was a player update the plot and attack
    if (((GetIsPC(oDisturber) == TRUE)||(GetIsPC(GetMaster(oDisturber)) == TRUE))
      && (iHostile < 110))
    {
        //HandoutQuestXP(oDisturber, iEXP);
        SetLocalInt(GetModule(), "A1_NATIVES", 110);

        AddJournalQuestEntry("a1_natives", 110, oDisturber);
        ExecuteScript("exe_a1_troghosti", GetModule());
    }

    return;
}
