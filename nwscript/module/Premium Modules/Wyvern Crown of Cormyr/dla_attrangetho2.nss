// April 2006
// B W-Husey
// Gather up all the horses in Thunderstone and return them to owner.

#include "dla_i0_horse"

void main()
{
    DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker());
    DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameThund1")));
    DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameThund2")));
    DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameThund3")));
    DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameHawk")));
    DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameDamsel")));
}
