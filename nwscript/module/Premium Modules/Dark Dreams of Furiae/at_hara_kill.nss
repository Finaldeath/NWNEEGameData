#include "ddf_journal"
#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();

    // Fix Repuation.
    //AdjustReputation(oPC, OBJECT_SELF, 100);

    // Kill Harasi
    SetImmortal(OBJECT_SELF, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF) ;

    // Update Journal
    SetLocalInt(GetModule(), "ddf_release_harasi", FALSE);
    SetLocalInt(GetModule(), "ddf_harasi_dead", TRUE);
    UpdateJournal(oPC);

    // Fight remaining mercs...
    int iCounter = 0;
    object oNPC = GetObjectByTag("MercenarySTI", iCounter);
    while(GetIsObjectValid(oNPC))
    {
        AdjustReputationWithFaction(oPC, oNPC, -100);

        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionAttack(oPC));

        iCounter = iCounter + 1;
        oNPC = GetObjectByTag("MercenarySTI", iCounter);
    }
}
