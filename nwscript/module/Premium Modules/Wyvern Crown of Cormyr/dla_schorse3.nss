
//December 2005
// B W-Husey
// PC has 3 horses, either here or in Thunderstone.

#include "dla_i0_horse"
int StartingConditional()
{
    int nHorses = 0;
    object oPC = GetPCSpeaker();
    /*
    if (GetArea(oPC) !=  GetArea(GetWaypointByTag("NameThund1"))) nHorses = DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameThund1")));
    if (GetArea(oPC) !=  GetArea(GetWaypointByTag("NameThund2"))) nHorses = nHorses+DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameThund2")));
    if (GetArea(oPC) !=  GetArea(GetWaypointByTag("NameThund3"))) nHorses = nHorses+DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameThund3")));
    if (GetArea(oPC) !=  GetArea(GetWaypointByTag("NameHawk"))) nHorses = nHorses+DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameHawk")));
    */
    //First 4 return only tied horses
    nHorses = DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameThund1")),TRUE);
    nHorses = nHorses+DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameThund2")),TRUE);
    nHorses = nHorses+DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameThund3")),TRUE);
    nHorses = nHorses+DLA_CountOwnedHorsesInArea(oPC,GetArea(GetWaypointByTag("NameHawk")),TRUE);
    nHorses = nHorses + DLA_GetNumHorsesOwned(oPC);  // does not return tied horses
    if(nHorses>2)
        return TRUE;
    return FALSE;
}


