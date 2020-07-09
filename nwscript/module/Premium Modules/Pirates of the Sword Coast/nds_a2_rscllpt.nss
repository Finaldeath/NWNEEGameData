//::///////////////////////////////////////////////
//:: Name nds_a2_rscllpt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDisturbed script for Pete
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oDisturber = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();

    // if Pete was not already hostile attack and change Faction
    if (GetIsReactionTypeHostile(oDisturber, oSelf) == FALSE)
    {
        // Make sure it's not a henchmen or familiar attacking
        if ((GetIsPC(GetMaster(oDisturber)) == TRUE)
         || (GetIsPossessedFamiliar(oDisturber) == TRUE))
        {
            oDisturber = GetMaster(oDisturber);
        }

        // if the attacker was a player continue
        if (GetIsPC(oDisturber) == TRUE)
        {
            SetLocalInt(oModule, "cac_a2_franc50", TRUE);
            SetLocalObject(oModule, "PETE_PC_TARGET", oDisturber);

            ChangeToStandardFaction(oSelf, STANDARD_FACTION_HOSTILE);
            DelayCommand(1.0f, AssignCommand(oSelf, DetermineCombatRound(oDisturber)));

            //HandoutQuestXP(oPC, iEXP);
            SetLocalInt(oModule, "A2_FRANC", 50);
            AddJournalQuestEntry("a2_franc", 50, oDisturber);
        }
    }

    return;
}
