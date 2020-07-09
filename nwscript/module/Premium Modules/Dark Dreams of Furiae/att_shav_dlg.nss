#include "ddf_util"
#include "x0_i0_position"

void main()
{
    object oEnter = GetEnteringObject();

    // Early out if a player character didn't trigger this
    if (GetIsPC(oEnter) == FALSE)
    {
        return;
    }

    // Get Shavann (early out if she's invalid)
    object oShav = GetObjectByTag("DDF_NPC_Shavann");
    if (GetIsObjectValid(oShav) == FALSE)
    {
        return;
    }

    if(GetLocalInt(oShav, "has_talked") == TRUE)
    {
        debug("Has already talked to shavann, not doing it again!");
        return;
    }
    if(IsInConversation(oShav) == TRUE) return;

    // If Shavann isn't hostile with you, then force the dialog
    int iRepPC = GetReputation(oShav, oEnter);
    if (iRepPC > 10)
    {
        AssignCommand(oShav, ActionMoveToObject(oEnter, TRUE));
        AssignCommand(oShav, ActionStartConversation(oEnter));

        // if Ulan is here, move him over to you too, so the conversation can work correctly...
        if(GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE)
        {
            object oUlan = GetObjectByTag("DDF_NPC_Ulan_Undercity");
            if(GetIsObjectValid(oUlan))
            {
                AssignCommand(oUlan, ActionMoveToObject(oEnter, TRUE));
            }
        }
    }

    string sTag = "shavann_undercity_fighter";
    int iCounter = 0;
    object oNPC = GetObjectByTag(sTag, iCounter);
    while(oNPC != OBJECT_INVALID)
    {
        debug("-- turning fighter to look at PC.");
        TurnToFaceObject(oEnter, oNPC);
        iCounter = iCounter + 1;
        oNPC = GetObjectByTag(sTag, iCounter);
    }


    debug("shav " + GetName(oShav) + " rep " + IntToString(iRepPC));
}
