// B W-Husey
// August 2005
// Set the destination to travel to, the time taken, and the cost.
#include "cu_functions"
void main()
{
    SetCustomToken(1001,"Lake Wyvernwater");
    object oPC = GetPCSpeaker();
    string sDest = "WP_LWEast";
    CalculateTravel(GetTag(GetArea(oPC)),sDest,oPC);
}
