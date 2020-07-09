// June 2003
// B W-Husey
// Use of rope and movement to waypoint in another area. This one takes the rope away.

#include "cu_functions"
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    object oPC = GetPCSpeaker();
    oItemToTake = GetItemPossessedBy(oPC, "Rope");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    GroupTransition(oPC,GetNearestObjectByTag("TP_Rope"));
}
