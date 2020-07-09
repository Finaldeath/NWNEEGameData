//////////////////////////////////////////////////////////////////
// dla_ex_archery - Archery Contest - Cutscene
// Original Scripter: Deva B. Winblood
// Last Modified By: Deva B. Winblood  8/02/2006
//===============================================================
// nArcheryState = state of archery
//               0 = initialize and announce, spawn audience
//               1 = First shot, and reactions
//               2 = Second shot, and reactions
//               3 = Third shot, and reactions
//               4 = Fourth shot, and reactions
//               5 = Fifth shot, and reactions
//               6 = Sixth shot, and reactions
//               7 = Announcement & pause before next match
// bArcheryOver = if set to TRUE it is over despawn audience
//                0 = match on (FALSE)
//                1 = match won (TRUE)
//                2 = match lost (TRUE)
/////////////////////////////////////////////////////////////////
#include "dla_i0_strings"
#include "dla_i0_horse"
#include "X0_INC_HENAI"
#include "x2_inc_cutscene"

//////////////////////////
// CONSTANTS
//////////////////////////
const int ARCHERY_WHITE = 1;
const int ARCHERY_BLACK = 3;
const int ARCHERY_BLUE = 5;
const int ARCHERY_RED = 7;
const int ARCHERY_GOLD = 9;
const int ARROW_WHITE_START = 627;  // 8 arrows
const int ARROW_BLACK_START = 639;  // 5 arrows
const int ARROW_BLUE_START = 640;   // 5 arrows
const int ARROW_RED_START = 645;    // 3 arrows
const int ARROW_YELLOW_START = 648; // 3 arrows
const int ARROW_HIT_NW = 0;
const int ARROW_HIT_N = 1;
const int ARROW_HIT_NE = 2;
const int ARROW_HIT_E = 3;
const int ARROW_HIT_SE = 4;
const int ARROW_HIT_S = 5;
const int ARROW_HIT_SW = 6;
const int ARROW_HIT_W = 7;
const float ARROW_DURATION_ARCHERY = 50.0;
const float NPC_HIT_TIMING = 1.0;
const float PC_HIT_TIMING = 3.0;

//////////////////////////
// PROTOTYPES
//////////////////////////


object privateDLA_CreateAudience(location lLoc);
void privateDLA_PossessionAIAudience(object oPC);
location privateDLA_GetAudienceSpawnLocation();
void privateDLA_SetupMatch(int nNumber,object oPC,object oClone=OBJECT_INVALID);
void privateDLA_MoveAssociates(object oPC);
void privateDLA_FreeAssociates(object oPC);


//////////////////////////////////////////////////////[ MAIN ]///
void main()
{
    object oPC=GetPCSpeaker();
    int nDay=GetCalendarDay()+GetCalendarMonth()*30+GetCalendarYear()*12*30;
//debug     if (oPC==OBJECT_INVALID||GetIsPC(oPC)!=TRUE) SendMessageToPC(GetFirstPC(),"NO PC!");
    DeleteLocalInt(oPC,"bArcheryOver");
    TakeGoldFromCreature(10,oPC,TRUE); // collect fee
    if (GetLocalInt(oPC,"nArcheryDay")!=nDay)
    { // new day
      SetLocalInt(oPC,"nArcheryDay",nDay);
      SetLocalInt(oPC,"nArcheryCompCount",1);
    } // new day
    else
    { // same day
      nDay=GetLocalInt(oPC,"nArcheryCompCount");
      nDay++;
      SetLocalInt(oPC,"nArcheryCompCount",nDay);
    } // same day
    SetLocalInt(GetModule(),"bArcheryMatchUnderWay",TRUE);
    DelayCommand(1.5,privateDLA_MoveAssociates(oPC));
    DelayCommand(2.0,privateDLA_SetupMatch(1,oPC));
}
//////////////////////////////////////////////////////[ MAIN ]///

///////////////////////////
// FUNCTIONS
///////////////////////////

void privateDLA_MaintainPCInvis(object oPC,object oClone)
{ // PURPOSE: Keep the cutscene invis/ghost while archery contest is active
    effect eGhost=EffectCutsceneGhost();
    effect eInvis=EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    if (GetIsObjectValid(oClone))
    { // keep waiting
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oPC,1.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oPC,1.0);
        DelayCommand(0.9,privateDLA_MaintainPCInvis(oPC,oClone));
    } // keep waiting
} // privateDLA_MaintainPCInvis()

object privateDLA_CreateClone(object oPC)
{ // PURPOSE: This will clone the PC after making the PC cutscene invis/ghost
    object oClone;
    effect eGhost=EffectCutsceneGhost();
    effect eInvis=EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oPC,1.0);
    oClone=CopyObject(oPC,GetLocation(oPC),OBJECT_INVALID,"PC_CLONE");
    ChangeToStandardFaction(oClone,STANDARD_FACTION_COMMONER);
/* debug
    if (!GetIsObjectValid(oClone))
    { // error
        SendMessageToPC(oPC,"ERROR: Clone for Archery Contest failed to appear!");
    } // error
*/
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oPC,1.0);
    DelayCommand(0.5,privateDLA_MaintainPCInvis(oPC,oClone));
    return oClone;
} // privateDLA_CreateClone()

void privateDLA_RemoveClone(object oPC,object oClone)
{ // PURPOSE: This will move oPC to oClones location - destroy the clone
  // and then remove cutscene ghost and cutscene invisibility from oPC
    AssignCommand(oPC,ClearAllActions(TRUE));
    AssignCommand(oPC,JumpToLocation(GetLocation(oClone)));
    DestroyObject(oClone);
} // privateDLA_RemoveClone()


void privateDLA_JumpAssociate(object oAssociate,object oWP)
{ // PURPOSE: Move associate to location and set to STAND GROUND
    if (GetIsObjectValid(oWP))
    { // waypoint exists
        if (GetArea(oWP)!=GetArea(oAssociate)||GetDistanceBetween(oAssociate,oWP)>3.5)
        { // move to area
            AssignCommand(oAssociate,JumpToObject(oWP));
            DelayCommand(1.0,privateDLA_JumpAssociate(oAssociate,oWP));
        } // move to area
        else
        { // set to stand ground
            AssignCommand(oAssociate,ClearAllActions());
            SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oAssociate);
        } // set to stand ground
    } // waypoint exists
} // privateDLA_JumpAssociate()


void privateDLA_MoveAssociates(object oPC)
{ // PURPOSE: To move associates out of the way
    object oWP=GetWaypointByTag("ARCHERY_ASSOC_WAIT");
    int nN=1;
    object oAssociate=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        AssignCommand(oAssociate,privateDLA_JumpAssociate(oAssociate,oWP));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        AssignCommand(oAssociate,privateDLA_JumpAssociate(oAssociate,oWP));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        AssignCommand(oAssociate,privateDLA_JumpAssociate(oAssociate,oWP));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        AssignCommand(oAssociate,privateDLA_JumpAssociate(oAssociate,oWP));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        AssignCommand(oAssociate,privateDLA_JumpAssociate(oAssociate,oWP));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC,nN);
    } // jump
} // privateDLA_MoveAssociates()


void privateDLA_FreeAssociates(object oPC)
{ // PURPOSE: To remove the stand ground flag from associates
    int nN=1;
    object oAssociate=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oAssociate);
        AssignCommand(oAssociate,ActionForceFollowObject(oPC,2.0));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oAssociate);
        AssignCommand(oAssociate,ActionForceFollowObject(oPC,2.5));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oAssociate);
        AssignCommand(oAssociate,ActionForceFollowObject(oPC,1.5));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oAssociate);
        AssignCommand(oAssociate,ActionForceFollowObject(oPC,1.5));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC,nN);
    } // jump
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // jump
        SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oAssociate);
        AssignCommand(oAssociate,ActionForceFollowObject(oPC,2.0));
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC,nN);
    } // jump
} // privateDLA_FreeAssociates()


void privateDLA_MoveTo(object oDestination,float fRange=1.5)
{ // PURPOSE: To move the NPC to oDestination and deal with any
  // stuck issues.  This function is recursive but, will carefully
  // terminate when destination is reached.
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  5/6/2006
  object oNPC=OBJECT_SELF;
  float fDist=GetDistanceBetween(oNPC,oDestination);
  float fLast;
  int nASC;
  float fR;
  if (GetArea(oDestination)!=GetArea(oNPC)||fDist>fRange)
  { // move
    fLast=GetLocalFloat(oNPC,"fLast");
    if (GetCurrentAction(oNPC)!=ACTION_MOVETOPOINT)
    { // move
      AssignCommand(oNPC,ClearAllActions(TRUE));
      AssignCommand(oNPC,ActionMoveToObject(oDestination,TRUE,fRange));
    } // move
    if (fLast==fDist)
    { // have not moved since last check
      nASC=GetLocalInt(oNPC,"nASC"); // anti-stuck counter
      nASC++;
      if (nASC==1)
      { // simple clear
        AssignCommand(oNPC,ClearAllActions(TRUE));
        AssignCommand(oNPC,ActionMoveToObject(oDestination,TRUE,fRange));
      } // simple clear
      else
      { // teleport
        AssignCommand(oNPC,ClearAllActions(TRUE));
        AssignCommand(oNPC,JumpToObject(oDestination));
      } // teleport
      SetLocalInt(oNPC,"nASC",nASC);
    } // have not moved since last check
    else
    { // set
      SetLocalFloat(oNPC,"fLast",fDist);
      DeleteLocalInt(oNPC,"nASC");
    } // set
    fR=IntToFloat(Random(20)+1)/10.0;
    DelayCommand(4.0+fR,privateDLA_MoveTo(oDestination,fRange));
  } // move
} // privateDLA_MoveTo()

void privateDLA_EquipAmmo(object oPC)
{ // PURPOSE: Per designer request this will provide 6 arrows or bolts
  // to the PC for each round.
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  5/7/2006
  string sRes="nw_wamar001";
  object oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  int nBT=GetBaseItemType(oItem);
  int nSlot=INVENTORY_SLOT_ARROWS;
  if (nBT==BASE_ITEM_HEAVYCROSSBOW||nBT==BASE_ITEM_LIGHTCROSSBOW)
  { // crossbows
    sRes="nw_wambo001";
    nSlot=INVENTORY_SLOT_BOLTS;
  } // crossbows
  oItem=CreateItemOnObject(sRes,oPC,6);
  AssignCommand(oPC,ActionEquipItem(oItem,nSlot));
} // privateDLA_EquipAmmo()

object privateDLA_GetAimPosition(object oCreature,int nR)
{ // PURPOSE: Return an object for where a successful hit should be aimed
  // Original Scripter: Deva B. Winblood
  // Last Modified by:  Deva B. Winblood  5/9/2006
  object oOb;
  string sPos="1";
  if (GetIsPC(oCreature)==FALSE) sPos="2";
  if (nR==1) sPos=sPos+"_nw";
  else if (nR==2) sPos=sPos+"_n";
  else if (nR==3) sPos=sPos+"_ne";
  else if (nR==4) sPos=sPos+"_e";
  else if (nR==5) sPos=sPos+"_se";
  else if (nR==6) sPos=sPos+"_s";
  else if (nR==7) sPos=sPos+"_sw";
  else if (nR==8) sPos=sPos+"_w";
  oOb=GetObjectByTag("archery_aim_"+sPos);
  return oOb;
} // privateDLA_GetAimPosition()

int privateDLA_GetHitVisualEffect(int nLoc,int nScore)
{ // PURPOSE: This will return a visual effect number to place a stuck arrow on
  // the target
  // Original Scripter: Deva B. Winblood
  // Last Modified by:  Deva B. Winblood  5/9/2006
  int nRet;
  int nR=nLoc;
  if (nScore==1)
  { // white
    if (nLoc==1) nRet=ARROW_WHITE_START+3;
    else if (nLoc==2) nRet=ARROW_WHITE_START+2;
    else if (nLoc==3) nRet=ARROW_WHITE_START+1;
    else if (nLoc==4) nRet=ARROW_WHITE_START;
    else if (nLoc==5) nRet=ARROW_WHITE_START+7;
    else if (nLoc==6) nRet=ARROW_WHITE_START+6;
    else if (nLoc==7) nRet=ARROW_WHITE_START+5;
    else if (nLoc==8) nRet=ARROW_WHITE_START+4;
  } // white
  else if (nScore==3)
  { // black
    if (nLoc==1) nRet=ARROW_BLACK_START+2;
    else if (nLoc==2) nRet=ARROW_BLACK_START+1;
    else if (nLoc==3) nRet=ARROW_BLACK_START;
    else if (nLoc==4) nRet=ARROW_BLACK_START;
    else if (nLoc==5) nRet=ARROW_BLACK_START+4;
    else if (nLoc==6) nRet=ARROW_BLACK_START+4;
    else if (nLoc==7) nRet=ARROW_BLACK_START+3;
    else if (nLoc==8) nRet=ARROW_BLACK_START+3;
  } // black
  else if (nScore==5)
  { // blue
    if (nLoc==1) nRet=ARROW_BLUE_START+2;
    else if (nLoc==2) nRet=ARROW_BLUE_START+2;
    else if (nLoc==3) nRet=ARROW_BLUE_START+1;
    else if (nLoc==4) nRet=ARROW_BLUE_START+1;
    else if (nLoc==5) nRet=ARROW_BLUE_START;
    else if (nLoc==6) nRet=ARROW_BLUE_START+4;
    else if (nLoc==7) nRet=ARROW_BLUE_START+4;
    else if (nLoc==8) nRet=ARROW_BLUE_START+3;
  } // blue
  else if (nScore==7)
  { // red
    if (nLoc==1) nRet=ARROW_RED_START+1;
    else if (nLoc==2) nRet=ARROW_RED_START;
    else if (nLoc==3) nRet=ARROW_RED_START;
    else if (nLoc==4) nRet=ARROW_RED_START;
    else if (nLoc==5) nRet=ARROW_RED_START+2;
    else if (nLoc==6) nRet=ARROW_RED_START+2;
    else if (nLoc==7) nRet=ARROW_RED_START+2;
    else if (nLoc==8) nRet=ARROW_RED_START+1;
  } // red
  else
  { // yellow
    if (nLoc==1) nRet=ARROW_YELLOW_START+1;
    else if (nLoc==2) nRet=ARROW_YELLOW_START+1;
    else if (nLoc==3) nRet=ARROW_YELLOW_START;
    else if (nLoc==4) nRet=ARROW_YELLOW_START;
    else if (nLoc==5) nRet=ARROW_YELLOW_START+2;
    else if (nLoc==6) nRet=ARROW_YELLOW_START+2;
    else if (nLoc==7) nRet=ARROW_YELLOW_START+2;
    else if (nLoc==8) nRet=ARROW_YELLOW_START+1;
  } // yellow
  return nRet;
} // privateDLA_GetHitVisualEffect()


void privateDLA_RefereePosition()
{ // PURPOSE: Keep the referee where he is supposed to be
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  5/7/2006
  object oWP=GetWaypointByTag("WP_ARCHERY_REF");
  object oRef=GetObjectByTag("ARCHERY_REF");
  if (GetDistanceBetween(oRef,oWP)>0.9)
  { // move
    AssignCommand(oRef,ClearAllActions());
    AssignCommand(oRef,ActionJumpToObject(oWP));
    AssignCommand(oRef,ActionDoCommand(SetFacing(GetFacing(oWP))));
  } // move
} // privateDLA_RefereePosition()

void privateDLA_WearClothes(object oNPC,object oClothes)
{ // PURPOSE: Make sure NPC does not run around nude
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  5/3/2006
  object oItem=GetItemInSlot(INVENTORY_SLOT_CHEST,oNPC);
  if (oItem!=oClothes)
  { // keep trying
    AssignCommand(oNPC,ClearAllActions(TRUE));
    AssignCommand(oNPC,ActionEquipItem(oClothes,INVENTORY_SLOT_CHEST));
    DelayCommand(1.5,privateDLA_WearClothes(oNPC,oClothes));
  } // keep trying
} // privateDLA_WearClothes()

void privateDLA_SetCamera(int nNum)
{ // PURPOSE: To handle camera positioning at various points in the cutscene
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood  6/16/2006
  object oPC=OBJECT_SELF;
  object oPosition;
  if (nNum==1)
  { // first camera
    oPosition=GetWaypointByTag("ARCHERY_CAMERA_FRONT");
    AssignCommand(oPC,JumpToObject(oPosition));
    SetCameraFacing(12.0, 10.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
  } // first camera
  else if (nNum==2)
  { // second camera
    oPosition=GetWaypointByTag("ARCHERY_CAMERA_SIDE");
    AssignCommand(oPC,JumpToObject(oPosition));
    SetCameraFacing(90.0,5.0,75.0,CAMERA_TRANSITION_TYPE_SNAP);
  } // second camera
  else if (nNum==3)
  { // third camera
    oPosition=GetWaypointByTag("ARCHERY_CAMERA_CLOSE");
    AssignCommand(oPC,JumpToObject(oPosition));
    SetCameraFacing(30.0,5.5,75.0,CAMERA_TRANSITION_TYPE_SNAP);
  } // third camera
} // privateDLA_SetCamera()

object privateDLA_CreateAudience(location lLoc)
{ // PURPOSE: Spawn a male/female at a distance, pick 1 of
  // 8 types of clothing, pick random phenotype, pick random
  // head.
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood  5/6/2006
  object oNPC=OBJECT_INVALID;
  int nR;
  string sS;
  object oItem;
  object oWP;
  nR=d4();
  if (nR<4) oNPC=CreateObject(OBJECT_TYPE_CREATURE,"cac_cr_male",lLoc);
  else { oNPC=CreateObject(OBJECT_TYPE_CREATURE,"cac_cr_female",lLoc); }
  nR=d6();
  SetCreatureBodyPart(CREATURE_PART_HEAD,nR,oNPC);
  //nR=d4();
  //if (nR<2) SetPhenoType(PHENOTYPE_BIG,oNPC);
  nR=d8();
  if (nR==1) sS="nw_cloth022";
  else if (nR==2) sS="nw_cloth024";
  else if (nR==3) sS="nw_cloth003";
  else if (nR==4) sS="nw_cloth028";
  else if (nR==5) sS="nw_cloth001";
  else if (nR==6) sS="nw_cloth025";
  else if (nR==7) sS="nw_cloth006";
  else { sS="nw_cloth019"; }
  oItem=CreateItemOnObject(sS,oNPC);
  AssignCommand(oNPC,privateDLA_WearClothes(oNPC,oItem));
  oWP=GetNearestObject(OBJECT_TYPE_WAYPOINT,oNPC,1);
  if (GetTag(oWP)=="WP_TTGPatrol1_01")
  { // northern
    oItem=GetWaypointByTag("WP_ARCHERY_AUDIENCE"+IntToString(d2()+2));
  } // northern
  else
  { // southern or western
    oItem=GetWaypointByTag("WP_ARCHERY_AUDIENCE"+IntToString(d2()));
  } // southern or western
  SetLocalObject(oNPC,"oDest",oItem);
  return oNPC;
} // privateDLA_CreateAudience()


void privateDLA_PossessionAIAudience(object oPC)
{ // PURPOSE: Make the NPC walk and react as an audience member
  // when the oPC value bArcheryOver is TRUE the NPC needs to go and despawn
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood  5/6/2006
  object oMe=OBJECT_SELF;
  int nState=GetLocalInt(oMe,"nState");
  int nR;
  object oDest=GetLocalObject(oMe,"oDest");
  if (!GetLocalInt(GetModule(),"bArcheryMatchUnderWay")&&nState==0)
  { // setup despawn condition
    SetLocalInt(oMe,"nState",1);
    nR=d2();
    if (nR==1) oDest=GetWaypointByTag("WP_TTGWest1");
    else if (nR==2) oDest=GetWaypointByTag("WP_TTGSouth");
    SetLocalObject(oMe,"oDest",oDest);
  } // setup despawn condition
  if (nState==0)
  { // go to audience waypoint
    if (GetDistanceBetween(oMe,oDest)>2.5)
    { // not in range
      AssignCommand(oMe,ClearAllActions());
      AssignCommand(oMe,privateDLA_MoveTo(oDest));
    } // not in range
    else
    { // set facing
      SetFacing(GetFacing(oDest));
    } // set facing
  } // go to audience waypoint
  else if (nState==1)
  { // go to despawn waypoint
    if (GetDistanceBetween(oMe,oDest)>2.5)
    { // move
      AssignCommand(oMe,ClearAllActions());
      AssignCommand(oMe,privateDLA_MoveTo(oDest));
    } // move
    else
    { // despawn
      DestroyObject(oMe);
    } // despawn
  } // go to despawn waypoint
  DelayCommand(8.0,privateDLA_PossessionAIAudience(oPC));
} // privateDLA_PossessionAIAudience()


location privateDLA_GetAudienceSpawnLocation()
{ // PURPOSE: To return the location to spawn the audience members
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood   5/2/2006
  int nR=Random(3)+1;
  object oWP;
  if (nR==1) oWP=GetWaypointByTag("WP_TTGWest1");
  else if (nR==2) oWP=GetWaypointByTag("WP_TTGSouth");
  else { oWP=GetWaypointByTag("WP_TTGPatrol1_01"); }
  return GetLocation(oWP);
} // privateDLA_GetAudienceSpawnLocation()


int privateDLA_GetBaseArcheryAttackBonus(object oCreature)
{ // PURPOSE: Return the base attack bonus
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood  5/2/2006
  int bHasWeapFocus;
  int nLongBow = FEAT_WEAPON_FOCUS_LONGBOW;
  int nShortBow = FEAT_WEAPON_FOCUS_SHORTBOW;
  int nLCrossBow = FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW;
  int nHCrossBow = FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW;
  object oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCreature);
  int bHasZenArchery=GetHasFeat(FEAT_ZEN_ARCHERY,oCreature);
  int nBT=GetBaseItemType(oItem);
  int bElfBonus=FALSE;
  string sMsg=DLA_SetStringColor("Base Attack Calculations:","666");
  int nT;
  bHasWeapFocus = GetHasFeat(nLongBow || nShortBow || nLCrossBow
    || nHCrossBow, oCreature);
  int nAbilityMod=GetAbilityModifier(ABILITY_DEXTERITY, oCreature);
  if (GetAbilityModifier(ABILITY_WISDOM, oCreature)>nAbilityMod&&bHasZenArchery)
    nAbilityMod=GetAbilityModifier(ABILITY_WISDOM, oCreature);
  sMsg=sMsg+" Ability Modifier of "+DLA_SetStringColor(IntToString(nAbilityMod),"045")+" + ";
  if (bHasWeapFocus)
  { // has weapon focus
    nAbilityMod++;
    sMsg=sMsg+" Weapon Focus + 1 +";
  } // has weapon focus
  //if ((nBT==BASE_ITEM_LONGBOW||nBT==BASE_ITEM_SHORTBOW)&&GetRacialType(oCreature)==RACIAL_TYPE_ELF) nAbilityMod++;
  nT=nAbilityMod+GetBaseAttackBonus(oCreature);
  sMsg=sMsg+" BAB of "+DLA_SetStringColor(IntToString(GetBaseAttackBonus(oCreature)),"633")+" = ";
  sMsg=sMsg+DLA_SetStringColor(IntToString(nT),"666");
  if (GetIsPC(oCreature)) SendMessageToPC(oCreature,sMsg);
  return nT;
} // privateDLA_GetBaseArcheryAttackBonus()


string privateDLA_GetScoreWord(int nScore)
{ // PURPOSE: Return the name for the score and its color
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood 6/16/2006
  string sS=DLA_SetStringColor("MISS","060");
  if (nScore==-1) sS=DLA_SetStringColor("WILD SHOT","060");
  if (nScore==1) sS=DLA_SetStringColor("WHITE","666");
  else if (nScore==3) sS=DLA_SetStringColor("BLACK","333");
  else if (nScore==5) sS=DLA_SetStringColor("BLUE","006");
  else if (nScore==7) sS=DLA_SetStringColor("RED","600");
  else if (nScore==9) sS=DLA_SetStringColor("G O L D","432");
  return sS;
} // privateDLA_GetScoreWord()


int privateDLA_GetScoreForShot(object oCreature)
{ // PURPOSE: Calculate score for shot... will return -1 for really bad shot
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood   6/16/2006
  string sMsg;
  int nRoll=d20();
  int nScore=0;
  object oAn;
  int nBAB=privateDLA_GetBaseArcheryAttackBonus(oCreature);
  int nTotal=nRoll+nBAB;
  if (GetIsPC(oCreature))
  { // feedback
    sMsg=DLA_SetStringColor("ARCHERY SHOT CALCULATIONS:","060");
    sMsg=sMsg+" Check=Roll(d20) of "+DLA_SetStringColor(IntToString(nRoll),"666")+" + ";
    sMsg=sMsg+" Base Attack(and feats) of "+DLA_SetStringColor(IntToString(nBAB),"555")+" = ";
    sMsg=sMsg+DLA_SetStringColor(IntToString(nTotal),"060");
  } // feedback
  if (nRoll==1) nScore=-1;
  else if (nTotal<8) nScore=0;
  else if (nTotal<13) nScore=1;
  else if (nTotal<17) nScore=3;
  else if (nTotal<21) nScore=5;
  else if (nTotal<24) nScore=7;
  else { nScore=9; }
  if (nRoll==20)
  { // natural 20
    //oAn=GetObjectByTag("ARCHERY_REF");
    //AssignCommand(oAn,SpeakString("A perfect shot by "+GetName(oCreature)+"!"));
    nScore=9; // Natural 20
  } // natural 20
  sMsg=sMsg+"  "+privateDLA_GetScoreWord(nScore);
  if (GetIsPC(oCreature)) SendMessageToPC(oCreature,sMsg);
  return nScore;
} // privateDLA_GetScoreForShot()

object privateDLA_GetAudienceMember()
{ // PURPOSE: Get a random audience member
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood 5/2/2006
  object oRet=GetObjectByTag("cac_cr_male",Random(6));
  if (oRet==OBJECT_INVALID) oRet=GetObjectByTag("cac_cr_female",Random(4));
  if (oRet==OBJECT_INVALID)
  { // check
    if (d4()<4)
    { // male first
      oRet=GetObjectByTag("cac_cr_male",0);
      if (oRet==OBJECT_INVALID) oRet=GetObjectByTag("cac_cr_female",0);
    } // male first
    else
    { // female first
      oRet=GetObjectByTag("cac_cr_female",0);
      if (oRet==OBJECT_INVALID) oRet=GetObjectByTag("cac_cr_male",0);
    } // female first
  } // check
  return oRet;
} // privateDLA_GetAudienceMember()

void privateDLA_AudienceCheer()
{ // PURPOSE: To make one or more audience members cheer
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/3/2006
  object oOb=privateDLA_GetAudienceMember();
  if (oOb!=OBJECT_INVALID)
  { // found audience member
    AssignCommand(oOb,PlayVoiceChat(VOICE_CHAT_CHEER,oOb));
    AssignCommand(oOb,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0,3.0));
  } // found audience member
} // privateDLA_AudienceCheer()

void privateDLA_AudienceLaugh()
{ // PURPOSE: To make one or more audience members cheer
  // Original Scripter: Deva B. Winblood
  // Last Modified By:  Deva B. Winblood   5/7/2006
  object oOb=privateDLA_GetAudienceMember();
  if (oOb!=OBJECT_INVALID)
  { // found audience member
    AssignCommand(oOb,PlayVoiceChat(VOICE_CHAT_LAUGH,oOb));
  } // found audience member
} // privateDLA_AudienceLaugh()


void privateDLA_HandleRoundEnd(int nRound,object oPC,object oNPC,int nScoreP,int nScoreO,object oClone)
{ // PURPOSE: Handle the end of a round
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood  5/6/2006
  object oReferee=GetObjectByTag("ARCHERY_REF");
  object oExit=GetWaypointByTag("DLA_WP_ARCHERY_EXIT");
  AssignCommand(oPC,privateDLA_SetCamera(2));
  if (nScoreP<nScoreO)
  { // player loses
    privateDLA_RemoveClone(oPC,oClone);
    DelayCommand(6.0,SpeakString(GetName(oNPC)+" defeats "+DLA_SetStringColor(GetName(oPC),"600")+" and moves on to the next match!"));
    DelayCommand(6.5,privateDLA_AudienceCheer());
    SetLocalInt(oPC,"bArcheryOver",2);
    oReferee=GetWaypointByTag("DLA_ARCHER_WP_"+IntToString(nRound));
    AssignCommand(oNPC,ClearAllActions(TRUE));
    AssignCommand(oNPC,ActionMoveToObject(GetWaypointByTag("DLA_WP_ARCHERY_EXIT"),TRUE,1.0));
    AssignCommand(oNPC,ActionForceMoveToObject(oReferee,TRUE,1.0));
    AssignCommand(oNPC,ActionDoCommand(SetFacing(GetFacing(oReferee))));
    //DelayCommand(8.0, AssignCommand(oPC,CutSetCutsceneMode(0.1,oPC, FALSE,FALSE)));
    DelayCommand(8.0,SetCutsceneMode(oPC,FALSE));
    AssignCommand(oPC,ClearAllActions(TRUE));
    AssignCommand(oPC,ActionMoveToObject(oExit));
    oReferee=GetObjectByTag("ARCHERY_REF");
    AssignCommand(oPC,ActionStartConversation(oReferee,"archery_ref",FALSE,FALSE));
    DelayCommand(10.0,privateDLA_FreeAssociates(oPC));
    DeleteLocalInt(GetModule(),"bArcheryMatchUnderWay");
  } // player loses
  else
  { // player wins - also wins ties
    if (nRound>2)
    { // player wins the competition
      privateDLA_RemoveClone(oPC,oClone);
      DelayCommand(6.0,SpeakString(DLA_SetStringColor(GetName(oPC),"060")+" has won the match!  Amazing!"));
      DelayCommand(4.5,privateDLA_AudienceCheer());
      DelayCommand(5.0,privateDLA_AudienceCheer());
      oReferee=GetWaypointByTag("DLA_ARCHER_WP_"+IntToString(nRound));
      AssignCommand(oNPC,ClearAllActions(TRUE));
      AssignCommand(oNPC,ActionMoveToObject(GetWaypointByTag("DLA_WP_ARCHERY_EXIT"),TRUE,1.0));
      AssignCommand(oNPC,ActionForceMoveToObject(oReferee,TRUE,1.0));
      AssignCommand(oNPC,ActionDoCommand(SetFacing(GetFacing(oReferee))));
      SetLocalInt(oPC,"bArcheryOver",1);
      //DelayCommand(8.0, AssignCommand(oPC,CutSetCutsceneMode(0.1,oPC, FALSE,FALSE)));
      DelayCommand(8.0,SetCutsceneMode(oPC,FALSE));
      AssignCommand(oPC,ClearAllActions(TRUE));
      AssignCommand(oPC,ActionMoveToObject(oExit));
      oReferee=GetObjectByTag("ARCHERY_REF");
      AssignCommand(oPC,ActionStartConversation(oReferee,"archery_ref",FALSE,FALSE));
      DelayCommand(10.0,privateDLA_FreeAssociates(oPC));
      DeleteLocalInt(GetModule(),"bArcheryMatchUnderWay");
    } // player wins the competition
    else
    { // next round
      //privateDLA_RemoveClone(oPC,oClone);
      DelayCommand(6.0,SpeakString(DLA_SetStringColor(GetName(oPC),"060")+" is victorious and moves on to the next match!"));
      DelayCommand(4.5,privateDLA_AudienceCheer());
      //DelayCommand(7.0, SetCutsceneMode(oPC, FALSE));
      oReferee=GetWaypointByTag("DLA_ARCHER_WP_"+IntToString(nRound));
      AssignCommand(oNPC,ClearAllActions(TRUE));
      AssignCommand(oNPC,ActionMoveToObject(oExit,TRUE,1.0));
      AssignCommand(oNPC,ActionForceMoveToObject(oReferee,TRUE,1.0));
      AssignCommand(oNPC,ActionDoCommand(SetFacing(GetFacing(oReferee))));
      DelayCommand(7.0,privateDLA_SetupMatch(nRound+1,oPC,oClone));
    } // next round
  } // player wins - also wins ties
  privateDLA_RefereePosition();
} // privateDLA_HandleRoundEnd()

void privateDLA_DodgeMissfire()
{ // PURPOSE: To make the Announcer dodge a stray arrow
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood   5/4/2006
  object oAnnouncer=GetObjectByTag("DLA_ANNOUNCER");
  AssignCommand(oAnnouncer,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,5.0));
  AssignCommand(oAnnouncer,PlayVoiceChat(VOICE_CHAT_CUSS,oAnnouncer));
} // privateDLA_DodgeMissfire()


void privateDLA_ShootSixTimes(int nRound,object oPC,object oNPC,object oClone)
{ // PURPOSE: The have been verified they are at their place so, let us shoot
  // six times per opponent then tally the score.
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood  5/4/2006
  object oReferee=GetObjectByTag("ARCHERY_REF");
  object oAnnouncer=GetObjectByTag("DLA_ANNOUNCER");
  int nScoreP=GetLocalInt(oPC,"nArcheryScoreP");
  int nScoreO=GetLocalInt(oPC,"nArcheryScoreO");
  object oNPCTarget=GetObjectByTag("ARCHERY_TARGET_002");
  object oPCTarget=GetObjectByTag("ARCHERY_TARGET_001");
  object oMiss1=GetObjectByTag("ARCHERY_CONTEST_WILDSHOT1");
  object oMiss2=GetObjectByTag("ARCHERY_CONTEST_WILDSHOT2");
  int nCount=1;
  object oOb;
  object oTarget;
  int nR;
  int bCheer;
  string sColor;
  float fDelay=0.01;
  string sS;
  int nShot;
  int nLoc;
  effect eVFX;
  int nVFX;
  float fDif;
  while(nCount<=6)
  { // each contestant shoots 6 times
    bCheer=FALSE;
    nR=privateDLA_GetScoreForShot(oNPC);
    nShot=nR;
    if (nR==-1)
    { // misfire
      if (d4()<3) oOb=oMiss1;
      else { oOb=oMiss2; }
    } // misfire
    else
    { // not a misfire
      if (nR==0) oOb=GetObjectByTag("DLA_ARCHERY_MISS_002_"+IntToString(d2()));
      else
      { // NPC hit
        nLoc=Random(8)+1;
        oOb=privateDLA_GetAimPosition(oNPC,nLoc);
        nVFX=privateDLA_GetHitVisualEffect(nLoc,nR);
      } // NPC hit
    } // not a misfire
    sColor=privateDLA_GetScoreWord(nR);
    if (nR<1) sS=GetName(oNPC)+" "+sColor;
    else { sS=GetName(oNPC)+" hit "+sColor; }
    DelayCommand(fDelay,AssignCommand(oNPC,ActionAttack(oOb)));
    if (nR>0)
    { // hit
      eVFX=EffectVisualEffect(nVFX);
      fDif=ARROW_DURATION_ARCHERY-(IntToFloat(nCount)*6.0);
      DelayCommand(NPC_HIT_TIMING+fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVFX,oNPCTarget,fDif));
    } // hit
    DelayCommand(fDelay+3.0,AssignCommand(oNPC,ClearAllActions(TRUE)));
    if (nR>4) bCheer=TRUE;
    if (bCheer) DelayCommand(fDelay+2.5,privateDLA_AudienceCheer());
    if (nShot==-1)
    { // critical miss
      if (oOb==oMiss1) DelayCommand(2.5,privateDLA_DodgeMissfire());
      DelayCommand(fDelay+2.5,privateDLA_AudienceLaugh());
    } // critical miss
    if (nR>0) nScoreO=nScoreO+nR;
    bCheer=FALSE;
    nR=privateDLA_GetScoreForShot(oPC);
    nShot=nR;
    if (nR==-1)
    { // misfire
      if (d4()<3) oOb=oMiss1;
      else { oOb=oMiss2; }
    } // misfire
    else
    { // not a misfire
      if (nR==0) oOb=GetObjectByTag("DLA_ARCHERY_MISS_001_"+IntToString(d2()));
      else
      { // PC hit
        nLoc=Random(8)+1;
        oOb=privateDLA_GetAimPosition(oPC,nLoc);
        nVFX=privateDLA_GetHitVisualEffect(nLoc,nR);
      } // PC hit
    } // not a misfire
    sColor=privateDLA_GetScoreWord(nR);
    sS=sS+"    "+GetName(oPC);
    if (nR>0)
    { // hit
      eVFX=EffectVisualEffect(nVFX);
      fDif=ARROW_DURATION_ARCHERY-(IntToFloat(nCount)*6.0);
      DelayCommand(PC_HIT_TIMING+fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVFX,oPCTarget,fDif));
    } // hit
    if (nR<1) sS=sS+" "+sColor;
    else { sS=sS+" hit "+sColor; }
    if (nR>0) nScoreP=nScoreP+nR;
    DelayCommand(fDelay+2.0,AssignCommand(oClone,ActionAttack(oOb)));
    DelayCommand(fDelay+4.0,AssignCommand(oClone,ClearAllActions(TRUE)));
    if (nR>4) bCheer=TRUE;
    if (bCheer) DelayCommand(fDelay+4.5,privateDLA_AudienceCheer());
    if (nShot==-1)
    { // critical miss
      if (oOb==oMiss1) DelayCommand(2.5,privateDLA_DodgeMissfire());
      DelayCommand(fDelay+2.5,privateDLA_AudienceLaugh());
    } // critical miss
    DelayCommand(fDelay+4.5,FloatingTextStringOnCreature(sColor,oPC,FALSE));
    sS=sS+"   "+GetName(oNPC)+" "+IntToString(nScoreO)+" vs "+GetName(oPC);
    sS=sS+" "+IntToString(nScoreP);
    DelayCommand(fDelay+5.5,AssignCommand(oAnnouncer,SpeakString(sS)));
    fDelay=fDelay+6.0;
    nCount++;
  } // each contestant shoots 6 times
  SetLocalInt(oPC,"nArcheryScoreP",nScoreP);
  SetLocalInt(oPC,"nArcheryScoreO",nScoreO);
  DelayCommand(40.0,AssignCommand(oPC,privateDLA_SetCamera(3)));
  DelayCommand(50.0,privateDLA_HandleRoundEnd(nRound,oPC,oNPC,nScoreP,nScoreO,oClone));
  privateDLA_RefereePosition();
} // privateDLA_ShootSixTimes()


void privateDLA_DoRoundOfMatch(int nRound,object oPC,object oNPC,object oClone)
{ // PURPOSE: Do a round of the archery match - make sure reached dest first
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. WInblood  5/2/2006
  object oNPCWaypoint=GetWaypointByTag("DLA_ARCHER_WP_002");
  object oPCWaypoint=GetWaypointByTag("DLA_ARCHER_WP_001");
  privateDLA_EquipAmmo(oClone);
  if (GetDistanceBetween(oClone,oPCWaypoint)>1.0||GetDistanceBetween(oNPC,oNPCWaypoint)>1.0)
  { // get them moving the old fashioned way
    //FadeToBlack(oPC, FADE_SPEED_FAST);
    DelayCommand(1.0,AssignCommand(oClone,JumpToObject(oPCWaypoint)));
    DelayCommand(1.0, AssignCommand(oNPC,JumpToObject(oNPCWaypoint)));
    DelayCommand(3.0, FadeFromBlack(oPC));
    DelayCommand(2.5, AssignCommand(oPC,privateDLA_SetCamera(1)));
    DelayCommand(4.0,privateDLA_ShootSixTimes(nRound,oPC,oNPC,oClone));
  } // get them moving the old fashioned way
  else
  { // equal delay for the above fade
    DelayCommand(2.5, AssignCommand(oPC,privateDLA_SetCamera(1)));
    DelayCommand(4.0,privateDLA_ShootSixTimes(nRound,oPC,oNPC,oClone));
    FadeFromBlack(oPC);
  } // equal delay for the above fade
  privateDLA_RefereePosition();
} // privateDLA_DoRoundOfMatch()


void privateDLA_SetupMatch(int nNumber,object oPC,object oClone=OBJECT_INVALID)
{ // PURPOSE: To make sure the PC is in place... trigger the cutscene
  // walk NPC opponent into place.  Spawn audience if appropriate.
  // Original Scripter: Deva B. Winblood
  // Last Scripter: Deva B. Winblood  6/16/2006
  object oNPC=GetObjectByTag("DLA_ARCHER_"+IntToString(nNumber));
  object oNPCWaypoint=GetWaypointByTag("DLA_ARCHER_WP_002");
  object oPCWaypoint=GetWaypointByTag("DLA_ARCHER_WP_001");
  object oReferee=GetObjectByTag("ARCHERY_REF");
  string sS;
  object oMyClone=oClone;
  object oAudience;
  int nP;
  int nC;
  int nR;
  int nScoreO;
  int nScoreP;
  if (DLA_GetIsMounted(oPC))
  { // dismount
    DLA_Dismount(oPC,FALSE);
  } // dismount
  if (nNumber==1)
  { // initialize cutscene
      //AssignCommand(oPC,CutSetActiveCutscene(1,CUT_DELAY_TYPE_CONSTANT));
      //AssignCommand(oPC,CutSetCutsceneMode(0.01,oPC,TRUE,TRUE,TRUE,TRUE));
      SetCutsceneMode(oPC,TRUE);
  } // initialize cutscene
  if (oClone==OBJECT_INVALID)
  { // create the clone for camera control
      oMyClone=privateDLA_CreateClone(oPC);
      if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oMyClone)))
      { // equip the bow
          AssignCommand(oMyClone,ClearAllActions(TRUE));
          AssignCommand(oMyClone,ActionEquipMostDamagingRanged());
      } // equip the bow
  } // create the clone for camera control
  if (nNumber==1)
  { // round 1 begin
    AssignCommand(oReferee,SpeakString("Contestants take your places."));
    DeleteLocalInt(oPC,"nArcheryScoreP"); // reset scores to 0
    DeleteLocalInt(oPC,"nArcheryScoreO");
  } // round 1 begin
  nScoreO=GetLocalInt(oPC,"nArcheryScoreO");
  nScoreP=GetLocalInt(oPC,"nArcheryScoreP");
  FadeToBlack(oPC, FADE_SPEED_FAST);
  AssignCommand(oMyClone,JumpToObject(oPCWaypoint));
  AssignCommand(oNPC,ClearAllActions(TRUE));
  AssignCommand(oNPC,ActionEquipMostDamagingRanged());
  AssignCommand(oNPC,JumpToObject(oNPCWaypoint));
  DelayCommand(2.0, AssignCommand(oPC,privateDLA_SetCamera(2)));
  if (nNumber==1) sS="Come one! Come all!  A grand archery contest is about to begin!";
  else if (nNumber==2) sS="An exciting match continues in the archery contest!";
  else if (nNumber==3) sS="A must see finale to the archery contest is about to begin!";
  sS=sS+" The current contestants are "+GetName(oNPC)+" on the south side of the field and on the north";
  sS=sS+" the newcomer "+GetName(oPC)+"!!";
  sS=DLA_SetStringColor(sS,"643");
  if (nNumber==2) nScoreO=38;
  else if (nNumber==3) nScoreO=94;
  if (nNumber>1) nScoreO=nScoreO+(Random(10)-5);
  SetLocalInt(oPC,"nArcheryScoreO",nScoreO);
  sS=sS+DLA_SetStringColor(" The Score at this time is ","643")+DLA_SetStringColor(GetName(oNPC),"622")+" "+IntToString(nScoreO)+DLA_SetStringColor(" vs ","643");
  sS=sS+DLA_SetStringColor(GetName(oPC),"046")+" "+IntToString(nScoreP)+DLA_SetStringColor(".","643");
  DelayCommand(5.0,SpeakString(sS));
  nC=4;
  nP=70;
  if (nNumber==2) { nC=6; nP=85; }
  else if (nNumber==3) { nC=10; nP=100; }
  nR=d100();
  if (nR<=nP)
  { // audience spawned
    nR=Random(nC)+1;
    nC=1;
    while(nC<=nR)
    { // spawn audience member
      oAudience=privateDLA_CreateAudience(privateDLA_GetAudienceSpawnLocation());
      if (oAudience!=OBJECT_INVALID) AssignCommand(oAudience,privateDLA_PossessionAIAudience(oPC));
      nC++;
    } // spawn audience member
  } // audience spawned
  privateDLA_RefereePosition();
  DelayCommand(10.0,privateDLA_DoRoundOfMatch(nNumber,oPC,oNPC,oMyClone));
} // privateDLA_SetupMatch()
