// October 2005
// B W-Husey
// Unlock the Matron's door
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    //Once the PC has entered this trigger and has permission to enter, unlock door and destroy trigger.
    if (GetLocalInt(oPC,"LondroSide")>1 && GetIsDefPC(oPC))
    {
        SetLocked(GetObjectByTag("MMatronExit"),FALSE);
//        SendMessageToPC(oPC,"I fired the unlock script");
        DestroyObject(OBJECT_SELF,1.0);
    }
}


