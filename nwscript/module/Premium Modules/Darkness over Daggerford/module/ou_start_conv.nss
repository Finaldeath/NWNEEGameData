//generic conversation start for objects
//Author: Damian Brown (Luspr)
//Date: 17-Aug-2005
void main()
{
    object oPC = GetLastUsedBy();

    if(GetIsPC(oPC))
        {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(OBJECT_SELF, ActionStartConversation(oPC));
        }
}
