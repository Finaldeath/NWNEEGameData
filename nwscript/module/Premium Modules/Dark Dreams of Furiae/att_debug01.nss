#include "ddf_util"
#include "x0_i0_secret"

void main()
{

    debug("on enter trigger.");

    object oDetectTrigger = GetObjectByTag("UlanSecDoor");


    debug("trigger found: " + IntToString(GetIsObjectValid(oDetectTrigger)));

    if(GetIsSecretItemRevealed(oDetectTrigger))
    {
        // already found it!
        debug("-- is found...");
        return;
    }

    debug("-- revealing it...");
    RevealSecretItem("ulan_sec_door", oDetectTrigger);

}
