// B W-Husey
// August 2005
// Set the destination to travel to, the time taken, and the cost.
#include "cu_functions"
void main()
{
    SetCustomToken(1001,"Morfen");
    object oPC = GetPCSpeaker();
    string sDest = "WP_MNorth";
    CalculateTravel(GetTag(GetArea(oPC)),sDest,oPC);
}
