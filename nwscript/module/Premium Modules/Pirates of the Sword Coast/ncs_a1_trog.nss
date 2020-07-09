//::///////////////////////////////////////////////
//:: Name ncs_a1_trog
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spell Cast at script for the
    Troglodytes
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oCaster = GetLastSpellCaster();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHarmful = GetLastSpellHarmful();
    int iHostile = GetLocalInt(oModule, "A1_NATIVES");
    int iEXP = GetJournalQuestExperience("a1_natives");

    // if the spell is hostile start the system
    if ((iHarmful == TRUE) && (iHostile < 110))
    {
        // if the attacker was a player update the plot and attack
        if ((GetIsPC(oCaster) == TRUE) || (GetIsPC(GetMaster(oCaster)) == TRUE))
        {
            //HandoutQuestXP(oCaster, iEXP);
            SetLocalInt(oModule, "A1_NATIVES", 110);

            AddJournalQuestEntry("a1_natives", 110, oCaster);
            ExecuteScript("exe_a1_troghosti", GetModule());
        }
    }

    return;
}
