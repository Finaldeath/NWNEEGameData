#include "ddf_util"
#include "ddf_journal"

void main()
{
    debug("Rings of Sending identified.");
    SetLocalInt(GetModule(), "ddf_ring_identified", TRUE);

    // identify all 3 rings.

    object oRing = GetObjectByTag("RING_ALADARA");
    if(GetIsObjectValid(oRing) == FALSE) debug("Unable to identify ALADARA ring.");
    else SetIdentified(oRing, TRUE);

    oRing = GetObjectByTag("RING_ULAN");
    if(GetIsObjectValid(oRing) == FALSE) debug("Unable to identify ULAN ring.");
    else SetIdentified(oRing, TRUE);

    oRing = GetObjectByTag("RING_TEDDY");
    if(GetIsObjectValid(oRing) == FALSE) debug("Unable to identify TEDDY ring.");
    else SetIdentified(oRing, TRUE);

    UpdateJournal(GetPCSpeaker());
}
