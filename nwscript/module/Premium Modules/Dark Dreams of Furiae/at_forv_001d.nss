// (finished conversation 4, journal updated)

#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(GetModule(), "forvor_story_index", 4);

    //GiveXPToAll(oPC,XP_MEDIUM);

    UpdateJournal(oPC);
}
