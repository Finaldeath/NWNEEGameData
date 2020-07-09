// December 2005
// B W-Husey
// Triggers Edgar to talk.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("Edgar");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oOld,ActionStartConversation(oPC,"edgar",FALSE,FALSE));
        DestroyObject(OBJECT_SELF);
        AllParty("nFoundEdgar",oPC,1);
    }
}
