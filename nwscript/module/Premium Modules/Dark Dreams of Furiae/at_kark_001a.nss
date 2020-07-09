#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_partywide"
#include "nw_i0_generic"


void main()
{
    object oPC = GetPCSpeaker();

    AdjustReputation(oPC, OBJECT_SELF, -100);

    // DDF_NPC_KARK_CULTIST
    object oCultist = GetObjectByTag("DDF_NPC_KARK_CULTIST");
    int index = 0;
    while(GetIsObjectValid(oCultist) == TRUE)
    {
        debug("-- cultist set to attack PC.");

        ClearPersonalReputation(oCultist, oPC);
        ClearPersonalReputation(oPC, oCultist);

        AdjustReputation(oPC, oCultist, -100);

        AssignCommand(oCultist, ClearAllActions());
        AssignCommand(oCultist, ActionAttack(oPC));

        index = index + 1;
        oCultist = GetObjectByTag("DDF_NPC_KARK_CULTIST", index);
    }


    // Also make Aladara attack, if she is still alive.
    object oAladara = GetObjectByTag("DDF_NPC_Aladara");
    if(oAladara != OBJECT_INVALID && GetQuestState(AREA_NORTH_MARKET) != INVESTIGATION_COMPLETE)
    {
        debug("-- ak_kark_001a getting aladara to attack.");
        AdjustReputationWithFaction(oPC, oAladara, -100);
        AssignCommand(oAladara, ClearAllActions());
        AssignCommand(oAladara, ActionAttack(oPC));
    }

    // Teleport away...
    object oTarget = GetObjectByTag("NW_LIMBO_ULAN");
    AssignCommand(OBJECT_SELF, JumpToObject(oTarget, FALSE));

    // Now start fighting, myself
    // DetermineCombatRound();

    // Set the flag that aladara is dead and update journal
    //SetLocalInt(GetModule(), "ddf_karkualii_dead", TRUE);
    UpdateJournal(oPC);

    // Enable the worldwine pot
    object oPot = GetObjectByTag("FinalWorldwinePlot");
    SetUseableFlag(oPot, TRUE);
}
