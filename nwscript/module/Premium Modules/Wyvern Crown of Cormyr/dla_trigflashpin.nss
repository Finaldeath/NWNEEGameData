// October 2003
// B W-Husey
// Activate nearest map pin.
#include "cu_functions"

void main()
{
   if (GetIsDefPC(GetEnteringObject())) {
   object oPin = GetNearestObjectByTag("FlashPin");
   SetMapPinEnabled(oPin,1);
   DestroyObject(OBJECT_SELF); }
}
