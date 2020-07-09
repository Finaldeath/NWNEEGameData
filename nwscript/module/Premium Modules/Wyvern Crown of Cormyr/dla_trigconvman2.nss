// December 2005
// B W-Husey
// Triggers Manthis to talk.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("Manthia2");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oOld,ActionStartConversation(oPC));
        DestroyObject(OBJECT_SELF);
    }
}
