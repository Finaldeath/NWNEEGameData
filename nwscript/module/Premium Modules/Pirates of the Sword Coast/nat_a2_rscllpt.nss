//::///////////////////////////////////////////////
//:: Name nat_a2_rscllpt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Rascally Pete was physiclly attacked
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oAttacker = GetLastAttacker();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHostile = GetLocalInt(oModule, "A1_DWARF");

    // if Pete was not already hostile attack and change Faction
    if (GetIsReactionTypeHostile(oAttacker, oSelf) == FALSE)
    {
        // Make sure it's not a henchmen or familiar attacking
        if ((GetIsPC(GetMaster(oAttacker)) == TRUE)
         || (GetIsPossessedFamiliar(oAttacker) == TRUE))
        {
            oAttacker = GetMaster(oAttacker);
        }

        // if the attacker was a player continue
        if (GetIsPC(oAttacker) == TRUE)
        {
            SetLocalInt(oModule, "cac_a2_franc50", TRUE);
            SetLocalObject(oModule, "PETE_PC_TARGET", oAttacker);

            ChangeToStandardFaction(oSelf, STANDARD_FACTION_HOSTILE);
            DelayCommand(1.0f, AssignCommand(oSelf, DetermineCombatRound(oAttacker)));

            //HandoutQuestXP(oPC, iEXP);
            SetLocalInt(oModule, "A2_FRANC", 50);
            AddJournalQuestEntry("a2_franc", 50, oAttacker);
        }
    }

    return;
}
