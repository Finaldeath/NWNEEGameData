#include "ddf_journal"
#include "ddf_util"

void main()
{
    // Shift to Chaos
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP, TRUE);

    // Let Go (Do Nothing)

    debug("*** ULAN NOT DEAD ***");

    // Update Journal
    SetLocalInt(GetModule(), "ddf_deal_with_ulan", TRUE);
    SetLocalInt(GetModule(), "ddf_ulan_dead", FALSE);
    SetLocalInt(GetModule(), "ddf_ulan_knocked_out", FALSE);
    UpdateJournal(GetPCSpeaker());

    // Drop the ring of sending
    object oRing = GetItemPossessedBy(OBJECT_SELF, "RING_ULAN");
    if(oRing == OBJECT_INVALID)
    {
        debug("Unable to find RING_ULAN on OBJECT_SELF: " + GetName(OBJECT_SELF));
    }
    ActionPutDownItem(oRing);

    // Teleport to Limbo
    object oLimboWaypoint = GetWaypointByTag("NW_LIMBO_ULAN");
    location locWP = GetLocation( oLimboWaypoint );
    DelayCommand(3.0, ActionJumpToLocation(locWP));
}
