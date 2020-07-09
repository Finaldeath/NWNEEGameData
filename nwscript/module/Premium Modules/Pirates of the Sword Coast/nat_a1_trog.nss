//::///////////////////////////////////////////////
//:: Name nat_a1_trog
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A troglodyte in the village was physiclly
    attacked.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oAttacker = GetLastAttacker();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHostile = GetLocalInt(oModule, "A1_NATIVES");
    int iEXP = GetJournalQuestExperience("a1_natives");

    // If the plot says that the trogs aren't hostile, update it.
    if (iHostile < 110)
    {
        // if the attacker was a player update the plot and attack
        if ((GetIsPC(oAttacker) == TRUE) || (GetIsPC(GetMaster(oAttacker)) == TRUE))
        {
            //HandoutQuestXP(oAttacker, iEXP);
            SetLocalInt(oModule, "A1_NATIVES", 110);

            AddJournalQuestEntry("a1_natives", 110, oAttacker);
            ExecuteScript("exe_a1_troghosti", GetModule());
        }
    }

    return;
}
