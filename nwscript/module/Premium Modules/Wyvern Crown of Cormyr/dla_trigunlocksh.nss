// October 2005
// B W-Husey
// Unlock Ship's door
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    //Once the PC has entered this trigger and has permission to enter, unlock door and destroy trigger.
    if (GetLocalInt(oPC,"nAbduct")>0 && GetLocalInt(oPC,"nAbduct")<6 && GetIsDefPC(oPC))
    {
        SetLocked(GetObjectByTag("TDoorShipIn"),FALSE);
//        SendMessageToPC(oPC,"I fired the unlock script");
        DestroyObject(OBJECT_SELF,1.0);
    }
}


