// B W-Husey
// August 2005
// Set the destination to travel to, the time taken, and the cost (called by CalculateTravel).
#include "cu_functions"
void main()
{
    SetCustomToken(1001,"Wyvernwater Castle Caves");
    object oPC = GetPCSpeaker();
    string sDest = "WP_TestWCWC";
    CalculateTravel(GetTag(GetArea(oPC)),sDest,oPC);
}
