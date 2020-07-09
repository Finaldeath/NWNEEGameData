// B W-Husey
// August 2005
// Set the destination to travel to, the time taken, and the cost (called by CalculateTravel).
#include "cu_functions"
void main()
{
    SetCustomToken(1001,"Final Battle");
    object oPC = GetPCSpeaker();
    string sDest = "WP_PCToBattle";
    CalculateTravel(GetTag(GetArea(oPC)),sDest,oPC);
}
