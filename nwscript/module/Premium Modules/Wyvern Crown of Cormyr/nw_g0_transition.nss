////////////////////////////////////////////////////////////
// OnClick/OnAreaTransitionClick
// NW_G0_Transition.nss
// Copyright (c) 2001 Bioware Corp.
////////////////////////////////////////////////////////////
// Created By: Sydney Tang
// Created On: 2001-10-26
// Description: This is the default script that is called
//              if no OnClick script is specified for an
//              Area Transition Trigger or
//              if no OnAreaTransitionClick script is
//              specified for a Door that has a LinkedTo
//              Destination Type other than None.
////////////////////////////////////////////////////////////
//
//  Modified by Robert Faber 05/17/06
//  For:  horse area permissions
//
//  How it works:
//  if the target area is flagged as interior (indoors/underground), the
//  script cancels the transition and instead dismounts and hitches horses.
//
//  >>>>>YOU MUST ENSURE ALL AREA TERRAIN BUTTONS ARE PROPERLY SET.<<<<<
//
//  These can be found on the advanced tab of area properties.  For the
//  most part, new area wizard generation does this automatically based on
//  tileset, but double check it anway.  if you want to override an interior
//  area to allow horses, open the area properties (advanced tab->variables)
//  of the target area and assign a local int bAllowHorsesInArea = 1.
//
////////////////////////////////////////////////////////////

#include "dla_i0_horse"
#include "dla_i0_horseai"
#include "cu_functions"


void main()
{ // Modified by Deva B. Winblood   8/02/2006
  // a new function was written to handle this as this was being unsafely handled
  // in various scripts.

    object oPC = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    object oArea=GetArea(oTarget);
    int nN;
    int nL;
    object oSubHench;
    object oHench;
    int bHasHorse=FALSE;

   if(!DLA_GetIsInteriorAllowed(oArea))
   {
     if (DLA_GetIsMounted(oPC)) bHasHorse=TRUE;
     nN=1;
     oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
     while(GetIsObjectValid(oHench)&&!bHasHorse)
     { // check for horses
         if (DLA_GetIsMounted(oHench)||DLA_GetIsDLAHorse(oHench)) bHasHorse=TRUE;
         else
         { // test for henchmen horses
             nL=1;
             oSubHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oHench,nL);
             while(GetIsObjectValid(oSubHench))
             { // check to see if the henchman has horse henchmen
                 if (DLA_GetIsDLAHorse(oSubHench)) bHasHorse=TRUE;
                 nL++;
                 oSubHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oHench,nL);
             } // check to see if the henchman has horse henchmen
         } // test for henchmen horses
         nN++;
         oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
     } // check for horses
     if (bHasHorse)
     { // remove horses
         DLA_NoHorseTransition(oPC,oTarget);
     } // remove horses
     else
     { // quick transition
         AssignCommand(oPC,JumpToObject(oTarget));
         DelayCommand(0.1,DLA_SetAreaTransCameraFacing(oPC,oTarget));
     } // quick transition
   }
   else
   { // not interior
       AssignCommand(oPC,JumpToObject(oTarget));
       DelayCommand(0.1,DLA_SetAreaTransCameraFacing(oPC,oTarget));
   } // not interior


}
