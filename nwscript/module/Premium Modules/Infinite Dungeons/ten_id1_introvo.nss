//::////////////////////////////////////////////////////////////////////////////
//:: ten_id1_introvo
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On enter event to have a trigger create an NPC which will start a
    conversation with the entering object. The conversation will play the
    introductory VO for ID. This should be removed when the actual introductory
    cutscene is complete.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Jan 3, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_score"
#include "inc_id_liltimmy"

void main()
{
    // only trigger for a PC object
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) == TRUE)
    {
        if (GetFirstPC() == oPC)
        {
            DebugMessage("Entering object is the creating PC.");

            int nMainPlot = lt_GetDungeonLevel();
            int nTriggerPlot = GetLocalInt(GetModule(), "nTriggerPlot");

            if ((nMainPlot == ID_LOCAL_DUNGEON_NOT_ENTERED) && (nTriggerPlot == 0)) // intro conversation
            {
//                SetCutsceneMode(oPC, TRUE);

//                object oNarrator = CreateObject(OBJECT_TYPE_CREATURE, "intronarrative", GetLocation(OBJECT_SELF));
//                DelayCommand(1.5, AssignCommand(oNarrator, ActionStartConversation(oPC, "idvo", FALSE, FALSE)));
            } else if ((nMainPlot == ID_LOCAL_FIRST_DUNGEON_COMPLETED) && (nTriggerPlot == 1)) // first lieutenant done
            {
                SetCutsceneMode(oPC, TRUE);

                object oNarrator = CreateObject(OBJECT_TYPE_CREATURE, "intronarrative", GetLocation(OBJECT_SELF));
                DelayCommand(1.5, AssignCommand(oNarrator, ActionStartConversation(oPC, "id1_idvo", FALSE, FALSE)));
            } else if ((nMainPlot == ID_LOCAL_THIRD_DUNGEON_COMPLETED) && (nTriggerPlot == 2)) // all lieutenants done
            {
                SetCutsceneMode(oPC, TRUE);

                object oNarrator = CreateObject(OBJECT_TYPE_CREATURE, "intronarrative", GetLocation(OBJECT_SELF));
                DelayCommand(1.5, AssignCommand(oNarrator, ActionStartConversation(oPC, "id1_idvo", FALSE, FALSE)));
            } else if ((nMainPlot == ID_LOCAL_THIRD_BOSS_DEFEATED) && (nTriggerPlot == 3)) // all inner circle done
            {
                SetCutsceneMode(oPC, TRUE);

                object oNarrator = CreateObject(OBJECT_TYPE_CREATURE, "intronarrative", GetLocation(OBJECT_SELF));
                DelayCommand(1.5, AssignCommand(oNarrator, ActionStartConversation(oPC, "id1_idvo", FALSE, FALSE)));
            } else if ((nMainPlot == ID_LOCAL_HALASTER_TIMMY) && (nTriggerPlot == 4)) // halaster done
            {
                SetCutsceneMode(oPC, TRUE);

                object oNarrator = CreateObject(OBJECT_TYPE_CREATURE, "intronarrative", GetLocation(OBJECT_SELF));
                DelayCommand(1.5, AssignCommand(oNarrator, ActionStartConversation(oPC, "id1_idvo", FALSE, FALSE)));
            }
        } else
        {
            DebugMessage("Entering object is not the creating PC.");
        }
    } else
    {
        DebugMessage("Entering object is not a PC.");
    }
}
