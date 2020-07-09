// December 2005
// B W-Husey
// Triggers Latim to talk.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("Latim");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oOld,ActionStartConversation(oPC,"latim",FALSE,FALSE));
        DestroyObject(OBJECT_SELF);
    }
}
