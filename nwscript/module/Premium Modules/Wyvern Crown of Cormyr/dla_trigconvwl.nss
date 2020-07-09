// December 2005
// B W-Husey
// Triggers WL to talk.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("BattleWL");
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nWCrownGot")==1)
    {
        AssignCommand(oOld,ActionStartConversation(oPC,"",FALSE,FALSE));
        DestroyObject(OBJECT_SELF);
    }
}
