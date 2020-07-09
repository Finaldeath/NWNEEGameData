#include "inc_polymorphfix"
#include "_inc_generic"

// JE: Anybody have any idea what this script is for?

void main()
{
    object oPC = GetFirstPC();
    object oStart = GetWaypointByTag("cut_wp_start");

    while(oPC != OBJECT_INVALID)
    {
        RemovePolymorph(oPC);
        // JE: JumpToObject is not reliable
        //AssignCommand(oPC, JumpToObject(oStart));
        JumpPCsToLocation(GetLocation(oStart), 0, oPC);
        oPC = GetNextPC();
    }
}
