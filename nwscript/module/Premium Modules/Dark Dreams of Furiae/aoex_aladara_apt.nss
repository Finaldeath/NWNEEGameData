#include "ddf_util"

void main()
{
    object oPC = GetExitingObject();

    if(GetIsPC(oPC) == FALSE) return;

    object oModule = GetModule();

    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
    if(GetIsObjectValid(oTeddy) == FALSE)
    {
        debug("Could not find Teddy to move to front hallway.");
        return;
    }

    if(GetLocalInt(oModule, "ddf_teddy_dead") == TRUE)
    {
        debug("Teddy is dead, can't move him into the front hallway.");
        return;
    }

    object oHallwayWaypoint = GetObjectByTag("AladaraAptTeddy");
    if(GetIsObjectValid(oHallwayWaypoint) == FALSE)
    {
        debug("Unable to find hallway waypoint to move Teddy too.");
        return;
    }

    debug("Telling Teddy to move back to the front hallway. ");

    SetLocalInt(GetModule(), "ddf_teddy_apt_saw_pc", FALSE);

    AssignCommand(oTeddy, ClearAllActions());
    AssignCommand(oTeddy, ActionMoveToObject(oHallwayWaypoint, TRUE));

}
