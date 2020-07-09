//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_endhalas
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Conversation action taken script to wrap things up after the player has
    defeated Halaster and discovered the truth behind "little timie."
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov 18, 2005
//::////////////////////////////////////////////////////////////////////////////
#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"
void main()
{
    DebugMessage("\n\n\n\n\n cac_id1_endhalas called. \n\n\n\n\n");

    // April 6, 2006 - Grant
    // This script is running as many times as there are players for some
    // reason. As a hammer fix check the ID_MODULE_DUNGEON_LEVEL set on the next
    // line of code and if it is already set jump out.
    if (GetLocalInt(GetModule(), "ID_MODULE_DUNGEON_LEVEL") >= 15) return;

    DebugMessage("Inside loop.");

    // Set the module variable to indicate the player has completed the
    // halaster scenario.
    SetLocalInt(GetModule(), "ID_MODULE_DUNGEON_LEVEL", 15);

    // move all players back to little timmy's warehouse
    object oDungeonEntrance = GetObjectByTag("DungeonEntranceStairs");
    AssignCommand(oDungeonEntrance, PlayAnimation(ANIMATION_DOOR_CLOSE));
    object oPC = GetFirstPC();
    CreateItemOnObject("id1_TokenMastery", oPC);
    AddJournalQuestEntry("id1_main", 80, oPC, FALSE, TRUE);
    object oWaypoint = GetObjectByTag("HALASTER_TELEPORTER");
    object oArea;

    object oNarratorArea = GetObjectByTag("NarratorArea");
    SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 5);
    SetLocalObject(oNarratorArea, "TeleportWP", oWaypoint);
    object oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");

    while (oPC != OBJECT_INVALID)
    {
        // set the respawn point as the dungeon stairs
        SetLocalObject(oPC, "ptr_id1_door", oDungeonEntrance);

        // transport player to start location
        DebugMessage("Clearing actions. Point 3.");
        DelayCommand(0.01, AssignCommand(oPC, ClearAllActions()));
        DelayCommand(0.02, AssignCommand(oPC, ActionJumpToObject(oDestinationDoor)));

        // cycle to next PC
        oPC = GetNextPC();
    }
}
