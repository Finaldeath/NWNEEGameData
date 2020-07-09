// October 2003
// B W-Husey
// Activate nearest map pin.
#include "cu_functions"

void main()
{
   if (GetIsDefPC(GetEnteringObject()) && GetLocalInt(GetEnteringObject(),"nMainPlot")>2) {
   object oPin = GetNearestObjectByTag("FlashPinRoom");
   SetMapPinEnabled(oPin,1);
   DestroyObject(OBJECT_SELF); }
}
