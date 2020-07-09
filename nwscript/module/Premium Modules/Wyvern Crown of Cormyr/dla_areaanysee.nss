// dla_areaanysee
// June 2006
// B W-Husey
// Explore the area for the player
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))    ExploreAreaForPlayer(OBJECT_SELF,oPC);
}
