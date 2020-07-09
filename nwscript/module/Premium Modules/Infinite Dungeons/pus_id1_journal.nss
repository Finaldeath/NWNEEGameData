#include "inc_id1_score"

void main()
{
    DebugMessage("");
    DebugMessage("Dungeon journal used.");

    // get the player
    object oPC = GetItemActivator();
    DebugMessage("Player for journal is " + GetPCIdentifier(oPC));
    if (oPC != OBJECT_INVALID)
    {
        DebugMessage("  PC valid.");

        // if the dungeon entrance
        object oArea = GetArea(oPC);
        if (GetTag(oArea) != "DungeonEntrance")
        {
            DebugMessage("  Area is not dungeon entrance.");

            // if a dungeon is not selected
            object oDungeon = GetCurrentDungeon();
            if (oDungeon != OBJECT_INVALID)
            {
                DebugMessage("  Dungeon is valid.");

                int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");
                if ((nCurrentLevel > 0) && (nCurrentLevel <= nMaxLevel))
                {
                    // create the journal object
                    object oJournal = CreateObject(OBJECT_TYPE_CREATURE, "id1_journalcre", GetLocation(oPC));

                    // make ghost and paralyze and invisible
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oJournal);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneParalyze(), oJournal);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oJournal);

                    // start conversation with player
                    DelayCommand(1.0, AssignCommand(oJournal, ActionStartConversation(oPC, "id1_journal", TRUE, FALSE)));
                } else
                {
                    SendMessageToPC(oPC, "The current dungeon level is invalid.");
                }
            } else
            {
                SendMessageToPC(oPC, "The current dungeon is invalid.");
            }
        } else
        {
            SendMessageToPC(oPC, "The dungeon journal can only be used inside a dungeon.");
        }
    } else
    {
        DebugMessage("  Journal does not have a valid PC.");
    }
}
