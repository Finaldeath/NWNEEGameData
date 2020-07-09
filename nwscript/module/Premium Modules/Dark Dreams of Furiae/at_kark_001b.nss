#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_partywide"
#include "nw_i0_generic"

// this gets run when the player hits ESC to get out of a dialog
// early.

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    //AdjustReputation(oTarget, OBJECT_SELF,-100);
    // DDF_NPC_KARK_CULTIST
    AdjustReputationWithFaction(oPC, OBJECT_SELF, -100);

    object oCultist;

    int iCounter = 0;

    oCultist = GetObjectByTag("DDF_NPC_KARK_CULTIST", iCounter);

    while(oCultist != OBJECT_INVALID)
    {
        AssignCommand(oCultist, ActionAttack(oPC));
        iCounter += 1;
        oCultist = GetObjectByTag("DDF_NPC_KARK_CULTIST", iCounter);
    }

    // Also make Aladara attack, if she is still alive.
    object oAladara = GetObjectByTag("DDF_NPC_Aladara");
    if(oAladara != OBJECT_INVALID && GetQuestState(AREA_NORTH_MARKET) != INVESTIGATION_COMPLETE)
    {
        debug("-- getting aladara to attack.");
        AdjustReputationWithFaction(oPC, oAladara, -100);
        AssignCommand(oAladara, ClearAllActions());
        AssignCommand(oAladara, ActionAttack(oPC));
    }

    if(GetLocalInt(oModule, "ddf_karkualii_defeated") != TRUE )
    {
        if(GetLocalInt(oModule, "ddf_met_nightmare_karkualii") != TRUE)
        {
            SetLocalInt(oModule, "ddf_met_nightmare_karkualii", TRUE);

        }
        else
        {
            ActionAttack(oPC);
        }
    }
    else
    {
        object oTarget = GetObjectByTag("NW_LIMBO_ULAN");
        AssignCommand(OBJECT_SELF, JumpToObject(oTarget, FALSE));


        // Enable the worldwine pot
        object oPot = GetObjectByTag("FinalWorldwinePlot");
        SetUseableFlag(oPot, TRUE);

    }

    UpdateJournal(oPC);
}
