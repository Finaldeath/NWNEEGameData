//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_b5
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: Baerdeth and his Party attack the player
//:: Quest will be finished on Baerdeth's death (ndt_tm_baerdeth)
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "NW_I0_GENERIC"


const string NPC_TAG_FOREST_MALARITE = "CR_bghunt_forest_malarite";
const string NPC_TAG_BAERDETH = "HuntmasterBaerdeth";


// Makes Baerdeth and Malarites attack
void npcAttack(object oPC)
{
    // Make Baerdeth attack
    object oBaerdeth = GetNearestObjectByTag(NPC_TAG_BAERDETH, oPC);
    SetPlotFlag(oBaerdeth, FALSE);
    SetImmortal(oBaerdeth, FALSE);
    ChangeToStandardFaction(oBaerdeth, STANDARD_FACTION_HOSTILE);
    AssignCommand(oBaerdeth, ClearAllActions(TRUE));
    AssignCommand(oBaerdeth, DetermineCombatRound());

    // Make a number of Malarites attack as well
    int nNth = 1;
    object oMalarite = GetNearestObjectByTag(NPC_TAG_FOREST_MALARITE, oPC, nNth);
    while (GetIsObjectValid(oMalarite))
    {
        SetPlotFlag(oMalarite, FALSE);
        SetImmortal(oMalarite, FALSE);
        ChangeToStandardFaction(oMalarite, STANDARD_FACTION_HOSTILE);
        AssignCommand(oMalarite, ClearAllActions(TRUE));
        AssignCommand(oMalarite, DetermineCombatRound());
        AssignCommand(oMalarite, ActionAttack(oPC));

        nNth++;
        oMalarite = GetNearestObjectByTag(NPC_TAG_FOREST_MALARITE, oPC, nNth);
    }
}


void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("BigGameHunt", 70, oPC);

    SetLocalInt(OBJECT_SELF, "nBusy", 1);

    DelayCommand(2.0f, npcAttack(oPC));
}
