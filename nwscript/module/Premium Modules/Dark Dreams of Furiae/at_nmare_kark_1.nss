#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_partywide"
#include "nw_i0_generic"


void main()
{
    object oTarget = GetPCSpeaker();
    //AdjustReputation(oTarget, OBJECT_SELF,-100);
    // DDF_NPC_KARK_CULTIST
    AdjustReputationWithFaction(oTarget, OBJECT_SELF, -100);

    object oCultist;

    int iCounter = 0;

    oCultist = GetObjectByTag("DDF_NPC_KARK_CULTIST", iCounter);

    while(oCultist != OBJECT_INVALID)
    {
        AssignCommand(oCultist, ActionAttack(oTarget));
        iCounter += 1;
        oCultist = GetObjectByTag("DDF_NPC_KARK_CULTIST", iCounter);
    }

    // Also make Aladara attack, if she is still alive.
    object oAladara = GetObjectByTag("DDF_NPC_Aladara");
    if(oAladara != OBJECT_INVALID && GetQuestState(AREA_NORTH_MARKET) != INVESTIGATION_COMPLETE)
    {
        debug("-- getting aladara to attack.");
        AdjustReputationWithFaction(oTarget, oAladara, -100);
        AssignCommand(oAladara, ClearAllActions());
        AssignCommand(oAladara, ActionAttack(oTarget));
    }

    if(GetLocalInt(GetModule(), "ddf_karkualii_defeated") != TRUE )
    {
        if(GetLocalInt(GetModule(), "ddf_met_nightmare_karkualii") != TRUE)
        {
            SetLocalInt(GetModule(), "ddf_met_nightmare_karkualii", TRUE);
            UpdateJournal(GetPCSpeaker());
        }
        else
        {
            ActionAttack(oTarget);
        }
    }
    else
    {
        object oTarget = GetObjectByTag("NW_LIMBO_ULAN");
        AssignCommand(OBJECT_SELF, JumpToObject(oTarget, FALSE));
    }
}
