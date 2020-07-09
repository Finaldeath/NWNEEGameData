// make a placeable start a dialog with the player

void main()
{
    object oPC;

    oPC = GetLastUsedBy();           // for placeables
    if (oPC == OBJECT_INVALID)
    {
        oPC = GetClickingObject();   // for doors that fail to open
    }
    if (oPC == OBJECT_INVALID)
    {
        SendMessageToPC(GetFirstPC(), "ERROR: null user in talk event");
    }
    ActionStartConversation(oPC);
}
