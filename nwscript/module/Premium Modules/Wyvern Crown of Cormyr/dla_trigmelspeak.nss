// December 2005
// B W-Husey
// Triggers Melee Master to talk.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("TTGMeleeMaster");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oOld,ActionStartConversation(oPC,"meleemaster",FALSE,FALSE));
//        DestroyObject(OBJECT_SELF);
    }
}
