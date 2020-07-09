// December 2005
// B W-Husey
// Triggers Keeper to talk.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("Keeper");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oOld,ActionMoveToObject(oPC));
        AssignCommand(oOld,ActionStartConversation(oPC,"keeper",FALSE,FALSE));
        DestroyObject(OBJECT_SELF);
    }
}
