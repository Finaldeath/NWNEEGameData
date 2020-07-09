// the player has read captain herab's book
// .. some griffons appear and confront the player

#include "hf_in_plot"
#include "hf_in_spawn"

void main()
{
    object oMod = GetModule();
    object oPC = GetPCSpeaker();
    int nCR = SpawnGetPartyCR(oPC, 50)/3;

    // update quests - ensure journal doesn't mention Astriel if not got quest from her
    if(GetLocalInt(GetModule(), "iBargeQuestGiven") == 0)
    {
        AddJournalQuestEntry ("barge_activity", 4, oPC, TRUE);
    }
    else
    {
         AddJournalQuestEntry ("barge_activity", 3, oPC, TRUE);
    }

    SetLocalInt(oMod, "barge_activity", 3);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);

    // guards appear and confront the player
    object oWP1 = GetWaypointByTag("WP_AR0501_GUARD1");
    object oGuard1 = CreateObject(OBJECT_TYPE_CREATURE, "ks_griffon_guard", GetLocation(oWP1));
    object oSword = GetItemPossessedBy(oGuard1, "NW_WSWLS001");
    AssignCommand(oGuard1, ActionEquipItem(oSword, INVENTORY_SLOT_RIGHTHAND));
    object oShield = GetItemPossessedBy(oGuard1, "NW_ASHLW001");
    AssignCommand(oGuard1, ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND));
    AssignCommand(oGuard1, ActionStartConversation(oPC));
    SpawnLevelupCreature(oGuard1, nCR);

    object oWP2 = GetWaypointByTag("WP_AR0501_GUARD2");
    object oGuard2 = CreateObject(OBJECT_TYPE_CREATURE, "ks_griffon_guard", GetLocation(oWP2));
    SpawnLevelupCreature(oGuard2, nCR);

    object oWP3 = GetWaypointByTag("WP_AR0501_GUARD3");
    object oGuard3 = CreateObject(OBJECT_TYPE_CREATURE, "ks_griffon_guard", GetLocation(oWP3));
    SpawnLevelupCreature(oGuard3, nCR);
}
