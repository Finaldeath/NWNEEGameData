// (finished conversation 4, journal updated, XP gained)

#include "ddf_util"
#include "ddf_journal"

void main()
{
    debug("-- at_coch_story_4");

    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    SetLocalInt(oModule, "cochrane_story_index", 4);
    //GiveXPToAll(oPC, XP_MEDIUM);
    UpdateJournal(oPC);

}
