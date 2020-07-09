#include "ddf_journal"
#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    // Shift to lawful / evil
    AdjustAlignment(oPC, ALIGNMENT_LAWFUL, ALIGNMENT_SLIP, TRUE);
    AdjustAlignment(oPC, ALIGNMENT_EVIL, ALIGNMENT_SLIP, TRUE);

    debug("*** ULAN NOT DEAD ***");

    // Update Journal
    SetLocalInt(oModule, "ddf_deal_with_ulan", TRUE);
    SetLocalInt(oModule, "ddf_ulan_dead", FALSE);
    SetLocalInt(oModule, "ddf_ulan_knocked_out", TRUE);
    UpdateJournal(oPC);

    // Drop the ring of sending
    object oRing = GetItemPossessedBy(OBJECT_SELF, "RING_ULAN");
    if(oRing == OBJECT_INVALID)
    {
        debug("Unable to get the RING_ULAN from OBJECT_SELF: " + GetName(OBJECT_SELF));
    }
    ActionPutDownItem(oRing);

    // Knockout
    DelayCommand(3.0, ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectKnockdown(), OBJECT_SELF ));
    DestroyObject(OBJECT_SELF, 5.0f);
}
