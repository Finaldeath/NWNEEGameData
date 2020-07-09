// January 2006
// B W-Husey
// Generic OnUsed script for objects that fire a conversation. Make sure they have one (advanced tab)

void main()
{
    object oPC = GetLastUsedBy();
    AssignCommand(oPC,ClearAllActions(TRUE));
    DelayCommand(0.1, ActionStartConversation(oPC));
}
