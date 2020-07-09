#include "ddf_util"

void main()
{
    object oTarget = GetObjectByTag("UlanSecretDoorWaypoint");
    if(oTarget == OBJECT_INVALID) debug("Unable to find ulans secret warehouse door in sea market.");

    MovePartyToObject(GetPCSpeaker(), oTarget);
}
