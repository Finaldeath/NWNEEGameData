//  (finished conversation 1, journal updated)
#include "ddf_util"
#include "ddf_journal"

void main()
{
    debug("-- at_coch_story_1");

    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    SetLocalInt(oModule, "cochrane_story_index", 1);
    UpdateJournal(oPC);

}
