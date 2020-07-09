#include "ddf_util"

void main()
{

    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
    object oNPC = GetEnteringObject ();

    if(oNPC != oTeddy)
    {
        debug("Not teddy... " + GetName(oNPC));
        return;
    }

    SetLocalInt(oTeddy, "teddy_run_warehouse", FALSE);
    SetLocalInt(oTeddy, "teddy_arrived_warehouse", TRUE);

}
