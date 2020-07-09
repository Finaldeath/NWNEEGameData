//If Wyvernwater has sunk, destroy the transition trigger.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nMainPlot")>5)
    DestroyObject(GetNearestObjectByTag("LWWest"));
}
