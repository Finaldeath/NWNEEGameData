#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    debug("-- debug Journal Start All NPC Stories");

    SetLocalInt(oModule, "forvor_story_index", 1);
    SetLocalInt(oModule, "luicil_story_index", 1);
    SetLocalInt(oModule, "kresh_story_index", 1);
    SetLocalInt(oModule, "tag_story_index", 1);
    SetLocalInt(oModule, "cochrane_story_index", 1);

    UpdateJournal(oPC);

}

