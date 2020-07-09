// October 2005
// B W-Husey
// Unlock the spy's door
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    //Once the PC has entered this trigger and has permission to enter, unlock door and destroy trigger.
    if (GetLocalInt(oPC,"nSpy")==8 && GetIsDefPC(oPC))
    {
        SetLocked(GetObjectByTag("TDoorSpyIn"),FALSE);
//        SendMessageToPC(oPC,"I fired the unlock script");
        DestroyObject(OBJECT_SELF,1.0);
    }
}


