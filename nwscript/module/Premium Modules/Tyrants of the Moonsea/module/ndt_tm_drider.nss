//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_tm_driders
// DATE: March 18, 2006
// AUTH: Luke Scull
// NOTE: See below.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "cut_tm_arena_inc"

// Make sure all three driders have been killed before firing the script
int nCount=GetLocalInt(GetFirstPC(), "driders");

void main()
{

    object oPC = GetFirstPC();

    nCount = nCount+1;
    SetLocalInt(GetFirstPC(), "driders", nCount);

    if (!(GetLocalInt(GetFirstPC(), "driders") == 3))
        return;

    SetLocalInt(oPC, "arena", 2);

    // fade out the screen,
    object oAnnouncer = GetObjectByTag(NPC_TAG_ANNOUNCER);
    //DelayCommand(3.0, AssignCommand(oAnnouncer, SpeakString("We have a winner!", TALKVOLUME_SHOUT)));
    DelayCommand(6.5, FadeToBlack(oPC, FADE_SPEED_MEDIUM));

    // jump player to cell
    object oWaypoint = GetObjectByTag(WP_TAG_PLAYER_CELLS);
    DelayCommand(7.5, AssignCommand(oPC, JumpToObject(oWaypoint)));
    DelayCommand(9.0, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));

    // update journal
    DelayCommand(8.0, AddJournalQuestEntry("TheArena", 60, oPC));

    // Clean up the corpse.
    DestroyObject(OBJECT_SELF, 12.0);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}

