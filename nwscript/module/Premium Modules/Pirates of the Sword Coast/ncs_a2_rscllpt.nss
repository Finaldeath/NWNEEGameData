//::///////////////////////////////////////////////
//:: Name ncs_a2_rscllpt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spell Cast at script for Pete
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oCaster = GetLastSpellCaster();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHarmful = GetLastSpellHarmful();

    // if Pete was not already hostile attack and change Faction
    if ((iHarmful == TRUE) && (GetIsReactionTypeHostile(oCaster, oSelf) == FALSE))
    {
        // Make sure it's not a henchmen or familiar attacking
        if ((GetIsPC(GetMaster(oCaster)) == TRUE)
         || (GetIsPossessedFamiliar(oCaster) == TRUE))
        {
            oCaster = GetMaster(oCaster);
        }

        // if the attacker was a player continue
        if (GetIsPC(oCaster) == TRUE)
        {
            SetLocalInt(oModule, "cac_a2_franc50", TRUE);
            SetLocalObject(oModule, "PETE_PC_TARGET", oCaster);

            ChangeToStandardFaction(oSelf, STANDARD_FACTION_HOSTILE);
            DelayCommand(1.0f, AssignCommand(oSelf, DetermineCombatRound(oCaster)));

            //HandoutQuestXP(oPC, iEXP);
            SetLocalInt(oModule, "A2_FRANC", 50);
            AddJournalQuestEntry("a2_franc", 50, oCaster);
        }
    }

    return;
}
