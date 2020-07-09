////////////////////////////////////////////////////////////////////////////////
// troubleshoot - Hot Fix 1 - Launch troubleshooting dialog
// By Deva B. Winblood   9/19/2006
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oMe=OBJECT_SELF;
    AssignCommand(oMe,ClearAllActions(TRUE));
    AssignCommand(oMe,ActionStartConversation(oMe,"troubleshooting",TRUE,FALSE));
}
