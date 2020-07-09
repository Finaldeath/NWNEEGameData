// November 2005
// B W-Husey
// PC has a henchman that is not a horse. Triggers a specific conversation.

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    //must be a PC starting the To be a Spy sidequest
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nSpy")==1)
    {
        object oHench = ReturnHenchman(oPC,1);
        if (oHench != OBJECT_INVALID)
        {
            AssignCommand(oPC,ClearAllActions());
            AssignCommand(oHench,ClearAllActions());
            AssignCommand(oHench,ActionStartConversation(oPC,"sembians",FALSE,FALSE));
        }
        DestroyObject(OBJECT_SELF,0.1); //get rid of trigger
    }

}
