#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    int FIN = 4;

    debug("-- debug Journal Start All NPC Stories");

    SetLocalInt(oModule, "forvor_story_index", FIN);
    SetLocalInt(oModule, "luicil_story_index", FIN);
    SetLocalInt(oModule, "kresh_story_index", FIN);
    SetLocalInt(oModule, "tag_story_index", FIN);
    SetLocalInt(oModule, "cochrane_story_index", FIN);

    UpdateJournal(oPC);

}

