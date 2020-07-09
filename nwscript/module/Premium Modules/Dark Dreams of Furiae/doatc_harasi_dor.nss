#include "ddf_util"


void main()
{
    object oPC = GetEnteringObject();
    int iPrevArea = GetPreviousArea(oPC);
    object oTarget;

    if(iPrevArea == AREA_RATHOLE_STREETS)
    {
        oTarget = GetObjectByTag("FromRatholeToHarasisApt");
        if(oTarget == OBJECT_INVALID) debug("Unable to find rathole door...");
        //MovePartyToObject(oPC, oTarget);
        AssignCommand(oPC, JumpToObject(oTarget));
    }
    else if(iPrevArea == AREA_ROOSTERS_ROOST)
    {
        oTarget = GetObjectByTag("FromRoostersToHarasisSmallApt");
        if(oTarget == OBJECT_INVALID) debug("Unable to find roosters door...");
        //MovePartyToObject(oPC, oTarget);
        AssignCommand(oPC, JumpToObject(oTarget));
    }
    else
    {
        debug("Error - i don't know how you got to Harasi's... " + IntToString(iPrevArea));
    }
}
