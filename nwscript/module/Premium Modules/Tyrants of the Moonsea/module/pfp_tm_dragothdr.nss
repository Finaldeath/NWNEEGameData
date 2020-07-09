// dragoth's exterior door talks to the player on fail to open
// sidequest: dragoth the bone mage

void main()
{
    object oPC = GetFirstPC();
    ActionStartConversation(oPC, "tm_dragothdoor");
}
