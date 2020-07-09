// October 2005
// B W-Huse
// Cutscene script to fire up the second conversation.

void main()
{
    object oSalvatori = GetNearestObjectByTag("SalvatoriCut1");
    object oPC = GetPCSpeaker();
    AssignCommand(oSalvatori,ActionStartConversation(oPC,"cut1a",FALSE,FALSE));
}
