#include "ddf_util"

void main()
{
    debug("-- trigger at front door...");

    object oEntering = GetEnteringObject();
    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

    if(oEntering != oTeddy) return;

    debug("-- triggered by Teddy! Sending to Limbo...");

    object oTarget = GetObjectByTag("NW_LIMBO_TEDDY");

    AssignCommand(oTeddy, ClearAllActions(TRUE));
    AssignCommand(oTeddy, JumpToObject(oTarget, FALSE));

}
