////////////////////////////////////////////////////////////////////////////////
// dla_miscgohome - Henchmen not assigned to PC need to return to Hench_tag
// Original Scripter: Deva B. Winblood
// Last Modified By:  B G P Hughes 22nd July - references to Salvatori calls changed to new name.
////////////////////////////////////////////////////////////////////////////////
// :: This script must be executed by the PC who enters the area
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_strings"
#include "dla_i0_horse"

//////////////////////////////////
// PROTOTYPES
//////////////////////////////////

// FILE: dla_miscgohome
// This function will move the specified henchman back to a waypoint
// with the tag of Hench_tag where tag is the NPCs tag if appropriate
// conditions are met. The nPlotState variable is used to determine
// appropriateness for doing this.
void DLA_MoveNPCIfAppropriate(object oNPC,int nPlotState);

// FILE: dla_miscgohome
// This function will return TRUE if the specified oArea is considered locked
// when the nPlotState is in its specified value.
int DLA_GetAreaIsLocked(object oArea,int nPlotState);

////////////////////////////////////////////////////////////////////[ MAIN ]////
void main()
{
   object oNPC;
   int nPlotState=GetLocalInt(OBJECT_SELF,"nMainPlot");
   oNPC=GetObjectByTag("Kathryn");
   if (oNPC!=OBJECT_INVALID)
   { // henchman found
     DLA_MoveNPCIfAppropriate(oNPC,nPlotState);
   } // henchman found
   oNPC=GetObjectByTag("Edgar");
   if (oNPC!=OBJECT_INVALID)
   { // henchman found
     DLA_MoveNPCIfAppropriate(oNPC,nPlotState);
   } // henchman found
   oNPC=GetObjectByTag("Lacinda");
   if (oNPC!=OBJECT_INVALID)
   { // henchman found
     DLA_MoveNPCIfAppropriate(oNPC,nPlotState);
   } // henchman found
   oNPC=GetObjectByTag("Godfroy");
   if (oNPC!=OBJECT_INVALID)
   { // henchman found
     DLA_MoveNPCIfAppropriate(oNPC,nPlotState);
   } // henchman found
   oNPC=GetObjectByTag("Jonas");
   if (oNPC!=OBJECT_INVALID)
   { // henchman found
     DLA_MoveNPCIfAppropriate(oNPC,nPlotState);
   } // henchman found
}
////////////////////////////////////////////////////////////////////[ MAIN ]////

///////////////////////////
// FUNCTIONS
///////////////////////////

int DLA_GetAreaIsLocked(object oArea,int nPlotState)
{ // PURPOSE: Return TRUE if oArea is locked for nPlotState
  // Original Scripter: Deva Winblood
  // Last Modified By:  Deva Winblood  6/16/2006
  string sName=GetName(oArea);
  string sParse;
  sName=GetStringLowerCase(sName); // make the name lower case
  sParse=DLA_ParseRight(sName,":");
  if (sName=="thunderstone: tournament ground"||sName=="thunderstone: jousting ground")
  { // check for locked tournament areas
      if (nPlotState!=0&&nPlotState!=1&&nPlotState!=7) return TRUE;
  } // check for locked tournament areas
  else if (nPlotState>5)
  { // castle wyvernwater
    if (sParse=="encounter") return TRUE;
    else if (sParse=="caste wyvernwater") return TRUE;
    else if (sParse=="polter's fort") return TRUE;
    else if (sParse=="hullack forest") return TRUE;
    else if (sParse=="morfen") return TRUE;
    else if (sParse=="tenant farms of salvatori") return TRUE;
    else if (sParse=="tenant farms of valetto stoutbold") return TRUE;
    else if (sParse=="on the road") return TRUE;
    else if (sParse=="your farm...") return TRUE;
  } // castle wyvernwater
  else if (nPlotState>4)
  { // Polter's Fort
    if (sParse=="encounter") return TRUE;
    else if (sParse=="polter's fort") return TRUE;
    else if (sParse=="hullack forest") return TRUE;
    else if (sParse=="morfen") return TRUE;
    else if (sParse=="tenant farms of salvatori") return TRUE;
    else if (sParse=="tenant farms of valetto stoutbold") return TRUE;
    else if (sParse=="on the road") return TRUE;
    else if (sParse=="your farm...") return TRUE;
  } // Polter's Fort
  else if (nPlotState>3)
  { // Hullack Forest
    if (sParse=="encounter") return TRUE;
    else if (sParse=="hullack forest") return TRUE;
    else if (sParse=="morfen") return TRUE;
    else if (sParse=="tenant farms of salvatori") return TRUE;
    else if (sParse=="tenant farms of valetto stoutbold") return TRUE;
    else if (sParse=="on the road") return TRUE;
    else if (sParse=="your farm...") return TRUE;
  } // Hullack Forest
  else if (nPlotState>1)
  { // Morfen, Tenant Farms, and On The Road
    if (sParse=="encounter") return TRUE;
    else if (sParse=="morfen") return TRUE;
    else if (sParse=="tenant farms of salvatori") return TRUE;
    else if (sParse=="tenant farms of valetto stoutbold") return TRUE;
    else if (sParse=="on the road") return TRUE;
    else if (sParse=="your farm...") return TRUE;
  } // Morfen, Tenant Farms, and On The Road
  return FALSE;
} // DLA_GetAreaIsLocked()
/*
void privateDLA_MoveLacindasHorse(object oHorse)
{ // PURPOSE: Move lacinda's horse
    object oWP=GetWaypointByTag("WP_lachorsestand");
    AssignCommand(oHorse,ClearAllActions(TRUE));
    AssignCommand(oHorse,JumpToObject(oWP));
    AssignCommand(oHorse,DLA_SetIsTied());
} // privateDLA_MoveLacindasHorse()

void privateDLA_LacindaDismount(object oLacinda)
{ // PURPOSE: To dismount Lacinda
    object oHorse=DLA_Dismount(oLacinda,FALSE,FALSE,TRUE,oLacinda);
    if (GetIsObjectValid(oHorse)) privateDLA_MoveLacindasHorse(oHorse);
} // privateDLA_LacindaDismount()
*/

void DLA_MoveNPCIfAppropriate(object oNPC,int nPlotState)
{ // PURPOSE: Determine if NPC should moved and if so move them
  // Original Scripter: Deva Winblood
  // Last Modified By:  Deva Winblood  5/15/2006
  object oWP;
  object oArea;
  if (!GetIsDead(oNPC))
  { // the NPC is not dead - and not linked to a PC
    if (GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oNPC,1)==OBJECT_INVALID)
    { // no PCs are present
      if (GetName(oNPC)=="Lacinda"&&DLA_GetIsMounted(oNPC))
      { // lacinda - deal with her horse
//          privateDLA_LacindaDismount(oNPC);
          DelayCommand(4.0,DLA_MoveNPCIfAppropriate(oNPC,nPlotState));
      } // lacinda - deal with her horse
      else
      { // not mounted lacinda
        oWP=GetWaypointByTag("Hench_"+GetTag(oNPC));
        if (oWP!=OBJECT_INVALID)
        { // destination is known
          oArea=GetArea(oNPC);
          if (DLA_GetAreaIsLocked(oArea,nPlotState))
          { // area is locked - move the henchman
            SetAILevel(oNPC,AI_LEVEL_NORMAL);
            AssignCommand(oNPC,ClearAllActions(TRUE));
            AssignCommand(oNPC,JumpToObject(oWP));
            DelayCommand(3.0,SetAILevel(oNPC,AI_LEVEL_DEFAULT));
          } // area is locked - move the henchman
        } // destination is known
       } // not mounted lacinda
    } // no PCs are present
  } // the NPC is not dead
} // DLA_MoveNPCIfAppropriate()
