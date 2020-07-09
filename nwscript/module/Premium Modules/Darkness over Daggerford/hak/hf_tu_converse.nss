// place this script in the onEnter event of a generic trigger.
// set variable HF_NPC_TAG on the encounter to the tag of a nearby NPC
// ... when the PC enters the trigger, the NPC will speak with the PC

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        string sTag = GetLocalString(OBJECT_SELF, "HF_NPC_TAG");
        object oNPC = GetNearestObjectByTag(sTag, oPC);
        if (GetIsObjectValid(oNPC))
        {
            AssignCommand(oNPC, ClearAllActions(TRUE));
            AssignCommand(oNPC, ActionStartConversation(oPC, "", FALSE, FALSE));
        } else {
            SendMessageToPC(oPC, "ERROR: invalid NPC tag - " + sTag);
        }
        if (!GetLocalInt(OBJECT_SELF, "HF_REPEATING"))
        {
            DestroyObject(OBJECT_SELF);
        }
    }
}
