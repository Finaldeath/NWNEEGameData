#include "ddf_journal"
#include "NW_I0_GENERIC"

void main()
{
    int iAttacked = GetLocalInt(GetModule(), "ddf_guvner_attack_guard");

    // If we've never attacked the guards
    if (iAttacked == FALSE)
    {
        object oPC = GetLastAttacker();

        // Remove the blocker
        object oBlocker = GetObjectByTag("RecordsBlocker");
        DestroyObject(oBlocker);

        // Make the faction hostile
        AdjustReputation(oPC,OBJECT_SELF,-100);
        DetermineCombatRound(oPC);

        // Update journal
        SetLocalInt(GetModule(), "ddf_guvner_attack_guard", TRUE);
        UpdateJournal(oPC);

        // Shift our alignment towards evil / chaotic
        AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP, TRUE);
        AdjustAlignment(oPC, ALIGNMENT_EVIL, ALIGNMENT_SLIP, TRUE);

    }

}
