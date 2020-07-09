// December 2005
// B W-Husey
// Triggers Fisherman to talk.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("Fisherman");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oOld,ActionStartConversation(oPC,"fisherman",FALSE,FALSE));
        DestroyObject(OBJECT_SELF,0.1);
    }
}
