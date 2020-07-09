////////////////////////////////////////////////////////////////////////////////
// dla_i0_animate - ANIMATION SUPPORT FOR MOUNTS
// Original Scripter: Deva B. Winblood      6/17/2006
// Last Modified By: Deva B. Winblood   6/22/2006
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////
// PROTOTYPES
///////////////////////////////////


// FILE: dla_i0_animate
// This function will return the proxy horse object to use to place beneath the
// PC when they attempt to mount.  If the proxy does not exist it will create
// it.  It will also set them to CutsceneGhost Permanently. It will also apply
// the correct tail to the proxy.
object DLA_Horse_GetAnimationProxy(object oRider,int nTail);

// FILE: dla_i0_animate    Function by: Erick "Gaoneng"
// This function will return the location to place the proxy horse to properly
// display the animation.
location DLA_Horse_GetAnimationProxyLocation(object oRider,float fDirection=90.0);


// FILE: dla_i0_animate
// This function will return the animation proxy to the holding location at the
// area with the waypoint tag WP_HORSE_MOUNT_DUMMY.
void DLA_Horse_RemoveAnimationProxy(object oProxy);


///////////////////////////////////
// FUNCTIONS
///////////////////////////////////

object DLA_Horse_GetAnimationProxy(object oRider,int nTail)
{ // PURPOSE: Return the animation proxy
   int nN;
   object oProxy;
   object oWP;
   string sTag="dla_horse_";
   effect eGhost=EffectCutsceneGhost();
   nN=GetRacialType(oRider);
   if (nN==RACIAL_TYPE_DWARF) sTag=sTag+"dwarf";
   else if (nN==RACIAL_TYPE_ELF) sTag=sTag+"elf";
   else if (nN==RACIAL_TYPE_GNOME) sTag=sTag+"gnome";
   else if (nN==RACIAL_TYPE_HALFELF) sTag=sTag+"helf";
   else if (nN==RACIAL_TYPE_HALFLING) sTag=sTag+"half";
   else if (nN==RACIAL_TYPE_HALFORC) sTag=sTag+"horc";
   else { sTag=sTag+"human"; }
   nN=GetGender(oRider);
   if (nN==GENDER_FEMALE) sTag=sTag+"f";
   else { sTag=sTag+"m"; }
   oProxy=GetObjectByTag(sTag);
   if (!GetIsObjectValid(oProxy))
   { // spawn proxy
       oWP=GetWaypointByTag("WP_HORSE_MOUNT_DUMMY");
       oProxy=CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(oWP));
   } // spawn proxy
   SetAILevel(oProxy,AI_LEVEL_NORMAL);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,eGhost,oProxy);
   SetCreatureTailType(nTail,oProxy);
   return oProxy;
} // DLA_Horse_GetAnimationProxy()



void DLA_Horse_RemoveAnimationProxy(object oProxy)
{ // PURPOSE: Move the animation proxy back to the storage location
   object oWP=GetWaypointByTag("WP_HORSE_MOUNT_DUMMY");
   if (GetIsObjectValid(oWP)&&GetIsObjectValid(oProxy))
   { // parameters are valid
      if (GetArea(oWP)!=GetArea(oProxy))
      { // jump
          AssignCommand(oProxy,ClearAllActions(TRUE));
          AssignCommand(oProxy,JumpToObject(oWP));
          DelayCommand(0.2,DLA_Horse_RemoveAnimationProxy(oProxy));
      } // jump
      else
      { // reduce AI level
          SetAILevel(oProxy,AI_LEVEL_VERY_LOW);
      } // reduce AI level
   } // parameters are valid
} // DLA_Horse_RemoveAnimationProxy()



location DLA_Horse_GetAnimationProxyLocation(object oRider,float fDirection=90.0)
{ // PURPOSE: To return location to place the mount
  // Original Script Design: Erick "Gaoneng"
  // Last Modified By: Deva B. Winblood   6/22/200
    object oArea=GetArea(oRider);
    vector vPos=GetPosition(oRider);
    float fFace=GetFacing(oRider);
    location lLoc;
    float fDist=0.8*StringToFloat(Get2DAString("appearance","WING_TAIL_SCALE",GetAppearanceType(oRider)));
    lLoc=Location(oArea,vPos+fDist*AngleToVector(fFace - fDirection),fFace);
    return lLoc;
} // DLA_Horse_GetAnimationProxyLocation()



//void main(){}
