// October 2005
// B W-Husey
// Unlock the Hawklin Castle door
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    //Once the PC has entered this trigger and has permission to enter castle, unlock door and destroy trigger.
    if (GetLocalInt(oPC,"nHawklinPlot1")>3 && GetIsDefPC(oPC))
    {
        SetLocked(GetObjectByTag("HCDoorEntrance"),FALSE);
//        SendMessageToPC(oPC,"I fired the unlock script");
        DestroyObject(OBJECT_SELF,1.0);
    }
    if (GetLocalInt(oPC,"nMainPlot")>1 && GetIsDefPC(oPC))      //overide for testing
    {
        SetLocked(GetObjectByTag("HCDoorEntrance"),FALSE);
//        SendMessageToPC(oPC,"I fired the unlock script");
        DestroyObject(OBJECT_SELF,1.0);
    }

}
