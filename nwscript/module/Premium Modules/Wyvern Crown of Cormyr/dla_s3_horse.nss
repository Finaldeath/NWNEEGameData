//::///////////////////////////////////////////////
//:: dla_s3_horse.nss
//:: (DLA)
//:://////////////////////////////////////////////
/*

Original scripting done by Gale, moved here for purposes of sub-radial usage.
DIRGE 01/06/05: Added henchman check to mount

Gale 17 April 2006: Added support to use it on a henchman, commanding the
henchman to mount a horse, if one is available on party.
Added support to use Dismount on same way.

Deva Winblood  May 13, 2006: added radial menu Party Mount, Party Dismount,
                             and Assign Mount support.
Deva Winblood  May 16, 2006: added bTargetedForMount flag to prevent multiple
                             people from trying to mount the same horse.
Deva Winblood  Jun 17, 2006: Worked on problems with PartyMount. Also worked
                             on Assign Mount issues.

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: May 29, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"


//////////////////////
// PROTOTYPES
//////////////////////

// private

// FILE: dla_s3_horse
// This function will attempt to find a mount for henchman oNPC
// this is broken into a function so, each henchman check can be delayed
// so more than one henchman does not attempt to mount the same horse.
void DLA_PartyMountNPC(object oNPC);



void main()
{
    //major variables declared
    object oPC = OBJECT_SELF;
    object oHorse = GetSpellTargetObject();
    object oNPC;
    int nN;
    float fF;

    //SendMessageToPC(GetFirstPC(),"dla_s3_horse: oPC:'"+GetName(oPC)+"' oHorse:'"+GetName(oHorse)+"' SpellId:"+IntToString(GetSpellId()));

    if (GetLocalInt(oPC,"bHorseActionActive")) return;

    switch(GetSpellId())
    {
        //dismount spell-feat
        case FEAT_DLA_HORSE_DISMOUNT:
        {
            oNPC = oHorse;
            if ((GetMaster(oNPC) == oPC) && GetAssociateType(oNPC) == ASSOCIATE_TYPE_HENCHMAN)
            {
               if (DLA_GetIsMounted(oNPC))
                 DLA_Dismount(oNPC);
            }
            else if(DLA_GetIsMounted(oPC))
                 DLA_Dismount(oPC);
            break;
        }
        //mount spell-feat
        case FEAT_DLA_HORSE_MOUNT:
        {
            if (!DLA_GetIsDLAHorse(oHorse)) //must be a proper horse appearance
            {

                oNPC = oHorse;
                /*
                Gale 16 April 2006: If it's not a horse, checking if it's one of
                player's henchmen. If so, make it mount if able to.
                */
                if ((GetMaster(oNPC) == oPC) && GetAssociateType(oNPC) == ASSOCIATE_TYPE_HENCHMAN)
                {
                    if (GetTag(oNPC)=="Lacinda")
                    { // check for lacinda's horse
                        oHorse=GetNearestObjectByTag("LacHorse",oNPC,1);
                        if (GetIsObjectValid(oHorse))
                        { // LacHorse found
                            if (!GetIsObjectValid(GetMaster(oHorse))) AddHenchman(oNPC,oHorse);
                            DLA_SetIsTied(oHorse,FALSE);
                        } // LacHorse found
                        else
                        { // normal horse
                            oHorse = DLA_GetHorseHenchman(oNPC, 1);
                            if (!GetIsObjectValid(oHorse))
                               oHorse = DLA_GetHorseHenchman(oPC, 1);
                        } // normal horse
                    } // check for lacinda's horse
                    else
                    { // not lacinda
                        oHorse = DLA_GetHorseHenchman(oNPC, 1);
                        if (!GetIsObjectValid(oHorse))
                          oHorse = DLA_GetHorseHenchman(oPC, 1);
                    } // not lacinda

                    if(GetIsObjectValid(oHorse))
                    {

                         if (!DLA_GetIsMounted(oNPC))
                         {
                              AssignCommand(oNPC, ClearAllActions(TRUE));
                              DLA_UnequipShield(oNPC);
                              DLA_UnequipForbiddenWeapon(oNPC);
                              //Delay to avoid being cleaned by the ClearAllActions called inside of
                              //both DLA_Unequip functions.
                              //SetLocalInt(oHorse,"bTargetedForMount",TRUE);
                              DelayCommand(0.2, DLA_Mount(oNPC, oHorse, FALSE));
                         }
                    }
                    else
                    {
                         //When PC horses gets removed after conversation node is showed
                         FloatingTextStringOnCreature("You don't have a horse available.", oPC, FALSE);
                         DeleteLocalInt(oPC,"bHorseActionActive");
                    }
                    return;
                }

                FloatingTextStringOnCreature("Invalid Target.", oPC, FALSE);
                DeleteLocalInt(oPC,"bHorseActionActive");
                return;
            }
            //horse be a henchman to mount OR be owned by a player's henchman,
            //and on dla_i0_switches, be seted that player can use henchman's horses.
            if((GetMaster(oHorse) != oPC) &&
               (GetMaster(GetMaster(oHorse)) != oPC ||
                 !DLA_PLAYER_CAN_MOUNT_HENCHMANS_HORSE))
            {
                FloatingTextStringOnCreature("You can't mount a horse you don't own.", oPC, FALSE);
                DeleteLocalInt(oPC,"bHorseActionActive");
                return;
            }
            if (GetDistanceBetween(oPC, oHorse) > DLA_MOUNT_MAXIMUM_DISTANCE) //short range only
            {
                FloatingTextStringOnCreature("The horse is too far away, move closer before mounting.", oPC, FALSE);
                DeleteLocalInt(oPC,"bHorseActionActive");
                return;
            }
            if (DLA_GetIsMounted(oPC)) //no longer mount when already mounted
            {
                FloatingTextStringOnCreature("You need to dismount first.", oPC, FALSE);
                DeleteLocalInt(oPC,"bHorseActionActive");
                return;
            }

            AssignCommand(oPC, ClearAllActions(TRUE));
            //Dirge 07/06/05: Calling CAA on horse as well, should help pull
            //them from their current animation
            AssignCommand(oHorse, ClearAllActions(TRUE));
            DLA_UnequipShield(oPC);
            DLA_UnequipForbiddenWeapon(oPC);
            //SetLocalInt(oHorse,"bTargetedForMount",TRUE);
            DelayCommand(0.1, DLA_Mount(oPC, oHorse, TRUE, DLA_HORSE_TAIL_AUTOMATIC));

            break;
        }

        case FEAT_DLA_HORSE_PARTY_MOUNT:
        { // Party Mount Radial menu selection
          if (DLA_GetIsDLAHorse(oHorse))
          { // horse selected
            if (DLA_GetIsTied(oHorse)) DLA_UntieHorse(oHorse);
            SetLocalInt(oHorse,"bTargetedForMount",TRUE);
            DLA_Mount(oPC,oHorse);
          } // horse selected
          else
          { // horse not specified
            oHorse=DLA_GetHorseHenchman(oPC,1);
            if (DLA_GetIsTied(oHorse)) DLA_UntieHorse(oHorse);
            SetLocalInt(oHorse,"bTargetedForMount",TRUE);
            DLA_Mount(oPC,oHorse);
          } // horse not specified
          nN=1;
          oNPC=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
          while(GetIsObjectValid(oNPC))
          { // check each henchman for mounting capability
            if (!DLA_GetIsDLAHorse(oNPC)&&!DLA_GetIsMounted(oNPC)&&GetAssociateType(oNPC)==ASSOCIATE_TYPE_HENCHMAN)
            { // not horses
              fF=3.0*IntToFloat(nN);
              DelayCommand(fF,DLA_HorseDebug("  dla_s3_horse: "+GetName(oNPC)+" party mount"));
              DelayCommand(fF+0.01,DLA_PartyMountNPC(oNPC));
            } // not horses
            nN++;
            oNPC=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
          } // check each henchman for mounting capability
          break;
        } // Party Mount Radial menu selection

        case FEAT_DLA_HORSE_PARTY_DISMOUNT:
        { // Party Dismount Radial menu selection
          if (DLA_GetIsMounted(oPC))
                DLA_Dismount(oPC);
          nN=1;
          oNPC=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);

          while(GetIsObjectValid(oNPC))
          { // check each henchman to see if mounted
            if (DLA_GetIsMounted(oNPC))
                    DLA_Dismount(oNPC);
            nN++;
            oNPC=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
          } // check each henchman to see if mounted

          break;
        } // Party Dismount Radial menu selection

        case FEAT_DLA_HORSE_ASSIGN_MOUNT:
        { // Assign Mount radial menu selection
          nN=GetLocalInt(oPC,"nDLAAssignMountTime");

          if (nN!=GetTimeHour())
          { // reset
            DeleteLocalInt(oPC,"nDLAAssignMountState");
          } // reset

          SetLocalInt(oPC,"nDLAAssignMountTime",GetTimeHour());
          nN=GetLocalInt(oPC,"nDLAAssignMountState");

          if (nN==0)
          { // initial state
            if (DLA_GetIsDLAHorse(oHorse))
            { // horse selected
              SetLocalObject(oPC,"oDLAAssignMount",oHorse);
              SetLocalInt(oPC,"nDLAAssignMountState",1);
              FloatingTextStringOnCreature("Use Assign Mount again on a henchman",oPC);
            } // horse selected
            else if (GetAssociateType(oHorse)==ASSOCIATE_TYPE_HENCHMAN)
            { // henchman selected
              SetLocalObject(oPC,"oDLAAssignMount",oHorse);
              SetLocalInt(oPC,"nDLAAssignMountState",2);
              FloatingTextStringOnCreature("Use Assign Mount again on a horse",oPC);
            } // henchman selected
          } // initial state

          else if (nN==1)
          { // pick henchman
            oNPC=GetLocalObject(oPC,"oDLAAssignMount");

            if (!DLA_GetIsDLAHorse(oHorse)&&GetAssociateType(oHorse)==ASSOCIATE_TYPE_HENCHMAN)
            { // is not a horse and is a henchman
              FloatingTextStringOnCreature("Assigned",oPC);
              SetLocalObject(oHorse,"oAssigned",oNPC);
              SetLocalObject(oNPC,"oAssigned",oHorse);
              DeleteLocalInt(oPC,"nDLAAssignMountState");
              DeleteLocalObject(oPC,"oDLAAssignMount");
              DeleteLocalInt(oPC,"nDLAAssignMountTime");
            } // is not a hotse and is a henchman

            else
            { // error
              DeleteLocalInt(oPC,"nDLAAssignMountState");
              DeleteLocalObject(oPC,"oDLAAssignMount");
              DeleteLocalInt(oPC,"nDLAAssignMountTime");
              FloatingTextStringOnCreature("Aborted",oPC);
            } // error

          } // pick henchman

          else if (nN==2)
          { // pick horse
            oNPC=GetLocalObject(oPC,"oDLAAssignMount");

            if (DLA_GetIsDLAHorse(oHorse))
            { // is a horse
              FloatingTextStringOnCreature("Assigned",oPC);
              SetLocalObject(oHorse,"oAssigned",oNPC);
              SetLocalObject(oNPC,"oAssigned",oHorse);
              DeleteLocalInt(oPC,"nDLAAssignMountState");
              DeleteLocalObject(oPC,"oDLAAssignMount");
              DeleteLocalInt(oPC,"nDLAAssignMountTime");
            } // is a horse

            else
            { // error
              DeleteLocalInt(oPC,"nDLAAssignMountState");
              DeleteLocalObject(oPC,"oDLAAssignMount");
              DeleteLocalInt(oPC,"nDLAAssignMountTime");
              FloatingTextStringOnCreature("Aborted",oPC);
            } // error

          } // pick horse
          break;
        } // Assign Mount Radial menu selection
        default: break;
    }
}


//////////////////////
// FUNCTIONS
//////////////////////


void DLA_PartyMountNPC(object oNPC)
{ // PURPOSE: This function will attempt to find a horse for this NPC to mount
  // and is provided so, each henchman can be delayed so as not to try to mount
  // same horse as another henchman.
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   6/17/2006
  object oHorse;
  int bFound=FALSE;
  object oPC=GetMaster(oNPC);
  int nN;
  int nC;
  object oAssigned;
  DLA_HorseDebug("DLA_PartyMountNPC("+GetName(oNPC)+")");
  oHorse=GetLocalObject(oNPC,"oAssigned");
  if (GetIsObjectValid(oHorse))
  { // a horse was previously assigned
    if (DLA_GetIsDLAHorse(oHorse)&&GetArea(oHorse)==GetArea(oNPC)&&GetDistanceBetween(oHorse,oNPC)<=10.0&&!DLA_GetIsMounted(oHorse)&&!GetLocalInt(oHorse,"bTargetedForMount"))
    { // so far this seems like a good match
      oAssigned=GetLocalObject(oHorse,"oAssigned");
      if (oAssigned==OBJECT_INVALID||oAssigned==oNPC||DLA_GetIsMounted(oAssigned))
      { // this is your horse
        bFound=TRUE;
      } // this is your horse
    } // so far this seems like a good match
  } // a horse was previously assigned
  if (!bFound)
  { // keep looking for a horse to ride
    nN=1;
    oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oNPC,nN);
    while(!bFound&&GetIsObjectValid(oHorse))
    { // check npc henchmen horses
      DLA_HorseDebug("        NPC Henchman:"+IntToString(nN)+" "+GetName(oHorse));
      if (DLA_GetIsDLAHorse(oHorse))
      { // horse
        if (GetArea(oHorse)==GetArea(oNPC)&&!DLA_GetIsMounted(oHorse)&&GetLocalObject(oHorse,"oAssigned")==OBJECT_INVALID&&!GetLocalInt(oHorse,"bTargetedForMount"))
        { // valid target
          bFound=TRUE;
        } // valid target
        if (!bFound)
        { // keep going
          nN++;
          oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oNPC,nN);
        } // keep going
      } // horse
      else
      { // other
          nN++;
          oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oNPC,nN);
      } // other
    } // check npc henchmen horses
    if (!bFound&&GetIsObjectValid(oPC))
    { // check PC horses
      nN=1;
      oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
      while(!bFound&&GetIsObjectValid(oHorse))
      { // check PC horses
        DLA_HorseDebug("        PC Henchman:"+IntToString(nN)+" "+GetName(oHorse));
        if (DLA_GetIsDLAHorse(oHorse))
        { // horse
          if (GetArea(oHorse)==GetArea(oNPC)&&!DLA_GetIsMounted(oHorse)&&GetLocalObject(oHorse,"oAssigned")==OBJECT_INVALID&&!GetLocalInt(oHorse,"bTargetedForMount"))
          { // valid target
            bFound=TRUE;
          } // valid target
          if (!bFound)
          { // keep going
            nN++;
            oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
          } // keep going
        } // horse
        else
        { // other
            nN++;
            oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
        } // other
      } // check PC horses
      if (!bFound&&GetHasFeat(FEAT_DLA_PALADIN_SUMMON_MOUNT,oNPC))
      { // summon paladin mount
        AssignCommand(oNPC,ActionUseFeat(FEAT_DLA_PALADIN_SUMMON_MOUNT,oNPC));
        AssignCommand(oNPC,ActionDoCommand(DLA_PartyMountNPC(oNPC)));
      } // summon paladin mount
    } // check PC horses
  } // keep looking for a horse to ride
  if (bFound)
  { // horse found
    DLA_HorseDebug("    Horse found:"+GetName(oHorse));
    SetLocalInt(oHorse,"bTargetedForMount",TRUE);
    if (DLA_GetIsTied(oHorse)) DLA_UntieHorse(oHorse);
    AssignCommand(oNPC,ActionMoveToObject(oHorse,TRUE,1.5));
    DelayCommand(1.0,DLA_Mount(oNPC,oHorse,FALSE));
  } // horse found
  else
  { // no horse found
    DLA_HorseDebug("    Horse not found:"+GetName(oNPC));
  } // no horse found
} // DLA_PartyMountNPC()
