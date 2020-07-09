//  (finished conversation 3, journal updated)
#include "ddf_util"
#include "ddf_journal"

void main()
{
    debug("-- at_coch_story_3");

    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    SetLocalInt(oModule, "cochrane_story_index", 3);
    UpdateJournal(oPC);

}
