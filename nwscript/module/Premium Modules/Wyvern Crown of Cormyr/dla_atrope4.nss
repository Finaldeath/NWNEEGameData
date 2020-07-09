// June 2003
// B W-Husey
// Use of rope and movement to waypoint in another area. This one gives the rope back.
#include "dla_i0_horse"
#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    DLA_RemovePartyHorsesAndLeaveOnPlace(oPC);
    GroupTransition(oPC,GetNearestObjectByTag("TP_RopeBack"));
    CreateItemOnObject("rope",oPC);
    AllParty("nLWRope2",oPC,0);//set variable so can't get back across
}
