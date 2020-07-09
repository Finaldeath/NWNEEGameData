#include "ddf_journal"

void main()
{

    object oTarget = GetPCSpeaker();
    AdjustReputation(oTarget, OBJECT_SELF,-100);
    ActionAttack(oTarget);


    SetLocalInt(GetModule(), "ddf_guvner_gain_entrance", TRUE);
    UpdateJournal(oTarget);
}
