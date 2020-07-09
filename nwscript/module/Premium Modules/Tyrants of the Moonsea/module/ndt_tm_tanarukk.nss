//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_tm_tanarukk
// DATE: March 18, 2006
// AUTH: Luke Scull
// NOTE: See below.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "cut_tm_arena_inc"

void main()
{
    object oPC = GetFirstPC();

    // update int
    SetLocalInt(oPC, "arena", 1);

    // fade out the screen
    object oAnnouncer = GetObjectByTag(NPC_TAG_ANNOUNCER);
    // DelayCommand(3.0, AssignCommand(oAnnouncer, SpeakString("We have a winner!", TALKVOLUME_SHOUT)));
    DelayCommand(6.5, FadeToBlack(oPC, FADE_SPEED_MEDIUM));

    // jump player to cell
    object oWaypoint = GetObjectByTag(WP_TAG_PLAYER_CELLS);
    DelayCommand(7.5, AssignCommand(oPC, JumpToObject(oWaypoint)));
    DelayCommand(9.0, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));

    // update journal
    DelayCommand(12.0, AddJournalQuestEntry("TheArena", 30, oPC));

    // remove the corpse
    DestroyObject(OBJECT_SELF, 13.0);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
