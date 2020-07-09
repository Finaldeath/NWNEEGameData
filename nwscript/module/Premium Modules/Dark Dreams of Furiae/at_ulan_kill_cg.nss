#include "ddf_journal"
#include "ddf_util"

void main()
{
    // Shift to Chaos / Good
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, ALIGNMENT_SLIP, TRUE);

    // Kill Ulan
    SetImmortal(OBJECT_SELF, FALSE);
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF ) ;

    debug("*** ULAN DEAD ***");

    // Update Journal
    SetLocalInt(GetModule(), "ddf_deal_with_ulan", TRUE);
    SetLocalInt(GetModule(), "ddf_ulan_dead", TRUE);
    SetLocalInt(GetModule(), "ddf_ulan_knocked_out", FALSE);
    UpdateJournal(GetPCSpeaker());
}
