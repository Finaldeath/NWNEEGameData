// June 2003
// B W-Husey
// Use of rope and movement to waypoint in another area. This one gives takes the rope
#include "dla_i0_horse"
#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(oPC, "Rope");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    DLA_RemovePartyHorsesAndLeaveOnPlace(oPC);
    GroupTransition(oPC,GetNearestObjectByTag("TP_RopeBack"));
    AllParty("nLWRope1",oPC,0);//set variable so can't get back across
}

