// March 2006
// B W-Husey
// PC is about to return Lacinda's horse. Get her and make her walk over.
// Modified by Deva B. Winblood  7/29/2006

#include "cu_functions"
#include "dla_i0_horse"

void main()
{
    object oPC = GetPCSpeaker();
    object oLac;
    location lLoc;
    object oHorse;
    object oRider;

    if(HasItemByTag(oPC,"LadysFavor"))
    {
        oLac = GetObjectByTag("Lacinda");
        lLoc = GetLocation(GetWaypointByTag("WP_SpawnLac"));
        AssignCommand(oLac,DelayCommand(2.0,JumpToLocation(lLoc)));
        AssignCommand(oLac,DelayCommand(8.0,ActionMoveToLocation(GetLocation(oPC),FALSE)));
        oHorse=GetObjectByTag("LacHorse");
        if (GetIsObjectValid(oHorse))
        { // horse exists

             oRider=GetLocalObject(oHorse,"oDLAMyMaster");
             if (GetIsObjectValid(oRider)||GetLocalInt(oHorse,"bStored"))
             { // is mounted - so make sure horse does not appear with Lacinda

                 lLoc=GetLocation(GetWaypointByTag(DLA_UNMOUNTED_MOUNT_MOVE));
                 SetAILevel(oHorse,AI_LEVEL_NORMAL);
                 SetCommandable(TRUE,oHorse);
                 AssignCommand(oHorse,ClearAllActions(TRUE));
                 AssignCommand(oHorse,ActionJumpToLocation(lLoc));
                 AssignCommand(oHorse,ActionDoCommand(SetCommandable(FALSE,oHorse)));

             } // is mounted - so make sure horse does not appear with Lacinda

        } // horse exists
    }
}
