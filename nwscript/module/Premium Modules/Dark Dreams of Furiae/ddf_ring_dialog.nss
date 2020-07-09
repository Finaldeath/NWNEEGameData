#include "ddf_util"

void TryRingDialog(object oPC)
{
    if(GetCurrentDay() == 5 && GetLocalInt(GetModule(), "ddf_ring_dialog_complete") == FALSE &&  (GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_COMPLETE || GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_COMPLETE || GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_COMPLETE))
    {
        if(GetLocalInt(GetModule(), IS_INVESTIGATING) == FALSE)
        {
            debug("Ring dialog should only trigger once you have finished the day's quest.");
            return;
        }

        debug("-- setup ring of sending dialog...");

        location lTarget = GetLocation(oPC);
        object oDialog = CreateObject(OBJECT_TYPE_PLACEABLE, "invis_ros", lTarget);

        if(GetIsObjectValid(oDialog) == FALSE)
        {
            debug("-- failed to create placeable object...");
            return;
        }

        SetName(oDialog, "Ring of Sending");

        AssignCommand(oDialog, ClearAllActions());
        AssignCommand(oDialog, ActionStartConversation(oPC, "ring_001"));

        SetLocalInt(GetModule(), "ddf_ring_dialog_complete", TRUE);
    }
}
