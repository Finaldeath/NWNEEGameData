// player enters the stronghold (might trigger a quest)

#include "inc_stronghold"
#include "hf_in_npc"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // setup a "messenger" encounter outside
        QuestStrongholdEnter(oPC);

        // the first time the player enters the stronghold, force convo with astriel
        if (GetLocalInt(OBJECT_SELF, "nPlayerEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nPlayerEntered", 1);
            TeleportToWaypoint(oPC, "WP_AR1301_CUT1_START", FALSE);
            object oAstriel = GetObjectByTag("db_astriel_lh");
            AssignCommand(oPC, ActionStartConversation(oAstriel));
        }

        // the first time the player enters the stronghold, set yani to appear
        if (GetLocalInt(GetModule(), "yani_appears") == 0)
        {
            SetLocalInt(GetModule(), "yani_appears", 1);
            DoSinglePlayerAutoSave();
        }
    }

    // this removes the door, leaving only its transition
    // ... just makes a nice archway instead of a door
    DestroyObject(GetObjectByTag("AR1301_AR1300_EXIT3"));
}
