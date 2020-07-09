#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetObjectByTag("yourneighborhood_arrival");
    MovePartyToObject(oPC, oTarget);

    //AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("yourneighborhood_arrival"), FALSE));
}
