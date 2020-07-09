//::///////////////////////////////////////////////
//:: dla_mod_hb
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Default Module OnHeartbeat script when using
   DLA Horses
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Nov 28, 2005
//:://////////////////////////////////////////////

#include "dla_inc_ride"
#include "dla_i0_faction"
#include "dla_i0_horse"


void privateFixStalkerHorse(object oLacHorse,object oPC);



void main()
{
    // Start looping
    object oPC = GetFirstPC(); // Init the PC object
    object oLacHorse;
    while(GetIsObjectValid(oPC))
    {
        //Deva 5/7/2006: Added call to clear hostility with standard factions
        DLA_AdjustFactions(oPC);
        if (DLA_GetIsMounted(oPC))
            DLA_DoRideChecks(oPC);
        oLacHorse=GetNearestObjectByTag("LacHorse",oPC,1);
        if (GetIsObjectValid(oLacHorse)&&GetMaster(oLacHorse)!=oPC)
        { // Check for stalker horse
             privateFixStalkerHorse(oLacHorse,oPC);
        } // Check for stalker horse
        else if (GetIsObjectValid(oLacHorse))
        { // set commandable
             SetCommandable(TRUE,oLacHorse);
        } // set commandable
        oPC = GetNextPC();
    }
}


void privateFixStalkerHorse(object oLacHorse,object oPC)
{ // PURPOSE: TO Put the stalker horse where they should be

     object oLacinda=GetObjectByTag("Lacinda");
     object oWPStand=GetWaypointByTag("WP_lachorsestand");
     object oDummy=GetWaypointByTag("WP_HORSE_MOUNT_DUMMY");

     if (GetMaster(oLacinda)==oPC)
     { // set commandable
          SetCommandable(TRUE,oLacHorse);
          return; // Lacinda is in the party
     } // set commandable

     if (GetTag(GetArea(oLacinda))=="INN"&&GetArea(oWPStand)!=GetArea(oLacHorse))
     { // outside sign of thunder

          SetAILevel(oLacHorse,AI_LEVEL_HIGH);
          SetCommandable(TRUE,oLacHorse);
          AssignCommand(oLacHorse,ClearAllActions(TRUE));
          AssignCommand(oLacHorse,JumpToObject(oWPStand));
          DelayCommand(2.0,SetAILevel(oLacHorse,AI_LEVEL_NORMAL));
          DelayCommand(2.1,DLA_SetIsTied(oLacHorse));

     } // outside sign of thunder
     else if ((DLA_GetIsMounted(oLacinda)&&GetLocalObject(oLacinda,"oDLAMyMount")==oLacHorse)||
               (GetArea(oLacinda)!=GetArea(oLacHorse)))
     { // horse should be in dummy area
          SetAILevel(oLacHorse,AI_LEVEL_HIGH);
          SetCommandable(TRUE,oLacHorse);
          AssignCommand(oLacHorse,ClearAllActions(TRUE));
          AssignCommand(oLacHorse,ActionJumpToObject(oDummy));
          AssignCommand(oLacHorse,ActionDoCommand(SetCommandable(FALSE,oLacHorse)));
          DelayCommand(3.0,SetAILevel(oLacHorse,AI_LEVEL_VERY_LOW));
     } // horse should be in dummy area


} // privateFixStalkerHorse()
