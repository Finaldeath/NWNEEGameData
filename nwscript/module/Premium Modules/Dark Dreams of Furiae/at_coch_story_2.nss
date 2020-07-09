//  (finished conversation 2, journal updated)
#include "ddf_util"
#include "ddf_journal"

void main()
{
    debug("-- at_coch_story_2");

    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    SetLocalInt(oModule, "cochrane_story_index", 2);
    UpdateJournal(oPC);

}
