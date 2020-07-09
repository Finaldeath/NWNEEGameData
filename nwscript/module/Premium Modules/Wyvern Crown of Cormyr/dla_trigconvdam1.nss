// November 2005
// B W-Husey
// Triggers the old an to give the second bit of information about the damsel quest.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("TFEOldMan");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oOld,ActionStartConversation(oPC,"damsel2",FALSE,FALSE));
        DestroyObject(OBJECT_SELF);
    }
}
