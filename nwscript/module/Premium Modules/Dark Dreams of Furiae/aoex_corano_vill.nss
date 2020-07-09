#include "ddf_util"

void main()
{
    object oPC = GetExitingObject();
    if(GetIsPC(oPC) == FALSE) return;

    debug("-- PC exiting Villa...");

    SetLocalInt(GetModule(), "ddf_pc_seen_flag", FALSE);

}
