#include "ddf_journal"
#include "ddf_util"

void main()
{
    // Drop the ring of sending
    object oRing = GetItemPossessedBy(OBJECT_SELF, "RingofSending");
    ActionPutDownItem(oRing);

    // Fix Reputation
    object oPC = GetPCSpeaker();
    AdjustReputation(oPC, OBJECT_SELF, 100);

    // Teleport to Limbo
    object oLimboWaypoint = GetWaypointByTag("NW_LIMBO_HARASI");
    location locWP = GetLocation( oLimboWaypoint );
    DelayCommand(3.0, ActionJumpToLocation(locWP));

    // Teleport remaining Mercs to Limbo
    int iCounter = 0;
    object oNPC = GetObjectByTag("MercenarySTI", iCounter);
    while(GetIsObjectValid(oNPC))
    {
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionJumpToLocation(locWP));
        iCounter = iCounter + 1;
        oNPC = GetObjectByTag("MercenarySTI", iCounter);
    }


    // Update Journal

    SetLocalInt(GetModule(), "ddf_confront_harasi", TRUE);
    SetLocalInt(GetModule(), "ddf_release_harasi", TRUE);
    SetLocalInt(GetModule(), "ddf_harasi_dead", FALSE);

    UpdateJournal(oPC);
}
