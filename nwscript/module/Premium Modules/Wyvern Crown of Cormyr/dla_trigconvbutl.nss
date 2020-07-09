// December 2005
// B W-Husey
// Triggers the butler to greet the PC. Once only.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oOld = GetNearestObjectByTag("Butler");
    if (GetIsDefPC(oPC))
    {
        AssignCommand(oOld,ActionStartConversation(oPC,"butler",FALSE,FALSE));
        DestroyObject(OBJECT_SELF);
    }
}
