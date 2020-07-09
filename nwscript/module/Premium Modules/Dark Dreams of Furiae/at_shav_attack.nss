#include "ddf_util"
#include "nw_i0_plot"
void main()
{
    string sTag = "shavann_undercity_fighter";
    string sSlave = "Slave_Undercity";
    string sWaypointTag = "SLAVE_EXIT_UNDERCITY";

    int iCounter = 0;

    object oTarget = GetPCSpeaker();
    object oNPC = GetObjectByTag(sTag, iCounter);

    //AdjustReputation(oTarget, OBJECT_SELF,-100);
    AdjustFactionReputation(oTarget, oNPC, -100);

    debug("-- Shavann Attack...");

    ActionAttack(oTarget);


    while(oNPC != OBJECT_INVALID)
    {
        debug("-- Shavann fighter attack...");
        AssignCommand(oNPC, ActionAttack(oTarget));

        iCounter = iCounter + 1;
        oNPC = GetObjectByTag(sTag, iCounter);
    }

    iCounter = 0;
    oNPC = GetObjectByTag(sSlave, iCounter);
    while(oNPC != OBJECT_INVALID)
    {
        debug("-- Shavann slave escape...");
        AssignCommand(oNPC, EscapeArea(TRUE, sWaypointTag));
        iCounter = iCounter + 1;
        oNPC = GetObjectByTag(sSlave, iCounter);
    }

    oNPC = GetObjectByTag("DDF_NPC_Ulan_Undercity");
    if(oNPC != OBJECT_INVALID)
    {
        debug("-- Shavann's Ulan attack...");
        AssignCommand(oNPC, ActionAttack(oTarget));
    }
}
