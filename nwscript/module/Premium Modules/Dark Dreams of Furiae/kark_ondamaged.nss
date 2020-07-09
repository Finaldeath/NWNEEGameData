// When Karkualii gets down to 1 HP,
// show her dialog (kark_001)
// an mark her as defeated
// pause the others from attacking till the
// dialog ends, then re-engage them.

#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_partywide"
#include "nw_i0_generic"


void main()
{
    object oModule = GetModule();
    object oPC = GetLastDamager();
    int iHP = GetCurrentHitPoints();

    // Check if we only have one hitpoint left
    if (iHP == 1 && GetLocalInt(oModule, "ddf_karkualii_defeated") != TRUE)
    {
        SetLocalInt(oModule, "ddf_karkualii_defeated", TRUE);
        SurrenderAllToEnemies(OBJECT_SELF);
        BeginConversation("", oPC);

        // Ensure that the final plot point is enabled...
        object oPot = GetObjectByTag("FinalWorldwinePlot");
        SetUseableFlag(oPot, TRUE);

        UpdateJournal(oPC);
    }
}
